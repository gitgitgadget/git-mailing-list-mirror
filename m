From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fsck: check ident lines in commit objects
Date: Sat, 24 Apr 2010 11:59:00 -0500
Message-ID: <20100424165900.GC14690@progeny.tock>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
 <20100424160608.GA14690@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 18:58:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5igZ-0002b5-DU
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 18:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab0DXQ61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 12:58:27 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41032 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab0DXQ6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 12:58:25 -0400
Received: by pwj9 with SMTP id 9so7575888pwj.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AWrTtrJbLF1fWGTSx1VesmaLAGqyol4J0TQ0rORQ50E=;
        b=hXkvPDYPFlH51S28oDYORAECPSE4DZt0IBKYoGYgfNYdUNtsloGWMLFi0rFYIzjiyg
         uOS4HyIHNfKDEHpXXqZPXIJbJ1oqcmL6PhN84UOSMps3Z4Iq/QgiilFP3KPdzXuAvjlq
         /DvzNHYFGRG1FU+sq/GGIuUbfUxfPE674xVG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=knjm+2Nve7Ca9fJNMySC8vsH2S9unzd4zdzczjhHBCm4SwkIpTr5layTH3L9K1cOgl
         e2nJ9LZdHH5WTSh3Q6Dcii8db6UKXX7IrD9Ig3vwCqttBX6SDp5ke3xB1AHmoz5pcos9
         z48K7C25gprMUTKFz5o4WJRzacuf5jpRVN2Co=
Received: by 10.143.86.3 with SMTP id o3mr834956wfl.182.1272128304969;
        Sat, 24 Apr 2010 09:58:24 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1619694iwn.0.2010.04.24.09.58.24
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 09:58:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424160608.GA14690@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145689>

Jonathan Nieder wrote:

> Check that email addresses do not contain <, >, or newline so they ca=
n
> be quickly scanned without trouble.

Test was bogus: the object format tests in fsck do not affect its exit
code.  Here=E2=80=99s a fixup.

Sorry for the trouble,
Jonathan

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index d8eed9b..22a80c8 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -64,7 +64,9 @@ test_expect_success 'email without @ is okay' '
 	new=3D$(git hash-object -t commit -w --stdin <okay) &&
 	echo "$new" &&
 	git update-ref refs/heads/bogus "$new" &&
-	git fsck
+	git fsck 2>out &&
+	cat out &&
+	! grep "error in commit $new" out
 '
 git update-ref -d refs/heads/bogus
 rm -f ".git/objects/$new"
@@ -77,6 +79,7 @@ test_expect_success 'email with embedded > is not oka=
y' '
 	echo "$new" &&
 	git update-ref refs/heads/bogus "$new" &&
 	git fsck 2>out &&
+	cat out &&
 	grep "error in commit $new" out
 '
 git update-ref -d refs/heads/bogus
