From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fixup! vcs-svn: improve reporting of input errors
Date: Thu, 24 Mar 2011 20:12:50 -0500
Message-ID: <20110325011250.GA20364@elie>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 02:13:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2vaT-0003sT-BA
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 02:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364Ab1CYBM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 21:12:58 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54103 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410Ab1CYBM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 21:12:57 -0400
Received: by ywj3 with SMTP id 3so261102ywj.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7HeEvxJBDMrK6bZP4Cp91zy1jM83MRgZ5sXOQ+FCia8=;
        b=KWkRkI6XZBr/wcFm42by3cFkJWAXZ4gpuDKblj+aJqX8krNwS/cJ+1VtnpC3ffSqLw
         g1gMrMDpXmhAhH5joptXDq1k2u0YWz0+i7+pl1SLmFCO2dmi6R85TfUWhgjcy4mzmEtq
         LJNtkrIzIrjxLEGLFQvn1SBKKLt11JZQpRBAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lYLa8VbWdjE5HPgYnkHGY2Vt28Qvq6E9CmDVnR//f3CAdS3CIkjvikiz/CFRsgX4ei
         KA7tnYzs0+1VpnShze3F9jXyK2buXN5WJjSlM2hjdENJjAA0z0EcvxEaBGJZr7bEDRsR
         Qg93T5nT8wZ3NhvYVE5biL48S53ATXkvI78Zk=
Received: by 10.101.129.27 with SMTP id g27mr134427ann.51.1301015576820;
        Thu, 24 Mar 2011 18:12:56 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.ameritech.net [68.255.102.141])
        by mx.google.com with ESMTPS id w39sm507690ana.13.2011.03.24.18.12.54
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 18:12:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169957>

Hi David,

David Barr wrote:

> An excessive constraint was introduced in c9d1c8ba; when reading
> svn props, it is permissible for both keys and values to contain
> nul characters.

Yes, that will work.

buffer_read_string returns a '\0'-terminated string and on early EOF,
the part after the end-of-file will be gibberish (and probably
uninitialized).  But it lives in an 1000-char buffer and errors out
when it doesn't fit, so at least with the fix it wouldn't crash.

Sorry for the breakage.  I suppose a test like the following would
catch future problems of this kind?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 5a6a4b9..a91b59c 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -370,6 +370,85 @@ test_expect_failure 'change file mode but keep old content' '
 	test_cmp hello actual.target
 '
 
+test_expect_failure 'null bytes' '
+	# Caveat: svnadmin 1.6.16 (r1073529) truncates at \0 in the
+	# svn:specialQnotreally example.
+	reinit_git &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	greeting
+	OBJID
+	:000000 100644 OBJID OBJID A	greeting
+	EOF
+	printf "%s\n" "something with a null byte (Q)" |
+		q_to_nul >expect.message &&
+	printf "%s\n" "helQo" |
+		q_to_nul >expect.hello1 &&
+	printf "%s\n" "link hello" >expect.hello2 &&
+	{
+		properties svn:log "something with a null byte (Q)" &&
+		echo PROPS-END
+	} |
+	q_to_nul >props &&
+	{
+		q_to_nul <<-\EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: greeting
+		Node-kind: file
+		Node-action: add
+		Prop-content-length: 10
+		Text-content-length: 6
+		Content-length: 16
+
+		PROPS-END
+		helQo
+
+		Revision-number: 2
+		EOF
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props &&
+		q_to_nul <<-\EOF
+
+		Node-path: greeting
+		Node-kind: file
+		Node-action: change
+		Prop-content-length: 43
+		Text-content-length: 11
+		Content-length: 54
+
+		K 21
+		svn:specialQnotreally
+		V 1
+		*
+		PROPS-END
+		link hello
+		EOF
+	} >8bitclean.dump &&
+	test-svn-fe 8bitclean.dump >stream &&
+	git fast-import <stream &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	git diff-tree --always -s --format=%s HEAD >actual.message &&
+	git cat-file blob HEAD^:greeting >actual.hello1 &&
+	git cat-file blob HEAD:greeting >actual.hello2 &&
+	test_cmp expect actual &&
+	test_cmp expect.message actual.message &&
+	test_cmp expect.hello1 actual.hello1 &&
+	test_cmp expect.hello2 actual.hello2
+'
+
 test_expect_success 'change file mode and reiterate content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
-- 
1.7.4.1
