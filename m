From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] remote-hg: unquote C-style paths when exporting
Date: Wed, 23 Oct 2013 08:44:11 -0700
Message-ID: <xmqqa9i0rnzo.fsf_-_@gitster.dls.corp.google.com>
References: <1382115821-12586-1-git-send-email-apelisse@gmail.com>
	<xmqq4n89t8yw.fsf@gitster.dls.corp.google.com>
	<CALWbr2zsOYNN45d+qHDQ88eLj82iV4QxJ_9ro+RGk7upBJVATA@mail.gmail.com>
	<CAMP44s37-R0u4oLnuRfdghx-Tk3X9eer0MVTcAGmPZ3Bu32dug@mail.gmail.com>
	<CALWbr2zzT47e_B0moy0a5gpWfhberp9B3TEwkGFBBm19iGfQBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0bb-0004fP-5K
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab3JWPoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:44:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36093 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3JWPoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 11:44:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D7654D4BB;
	Wed, 23 Oct 2013 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ikm1VdmoZ1BtHcA2vmt6urTs9IQ=; b=RhuGcd
	8cV4xpoatbA29X7i5W8PVqy1qirEwQBoNZmTmrigA5wVZ6f96uadCK41ZQ0mw5ru
	3/45tvXXCVo5NhywWJfISAZ7xFd7lsXn+LoRD7gCON7NsFPDWjrxDFMhsSSUlS1P
	ciKYEXqQ3XPQdUTFFkiDfLPUjAIIlyL/crRl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U8rd7a5iWBBp3khxqMrpCRwvGltE9Fgn
	oNYsg3do2sGjLkaZ8xkZGJJxW3CPtin5IKcI02uk1ZppJSSWyIRp1oCn65vTL2Ct
	Fbyuv/6HSSH9SxJ+qo1Soz91hjszjSMRHcD3s2HngCuYe1kQqdPFtyRGKnwyUANp
	GTxJHmh2CjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 813624D4BA;
	Wed, 23 Oct 2013 15:44:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8AD64D4B7;
	Wed, 23 Oct 2013 15:44:12 +0000 (UTC)
In-Reply-To: <CALWbr2zzT47e_B0moy0a5gpWfhberp9B3TEwkGFBBm19iGfQBw@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 23 Oct 2013 10:38:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F70D075C-3BF9-11E3-8A48-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236512>

Antoine Pelisse <apelisse@gmail.com> writes:

>> def c_style_unescape(string):
>>     if string[0] == string[-1] == '"':
>>         return string.decode('string-escape')[1:-1]
>>     return string
>>
>> It's in git-remote-bzr.py.
>
> Yeah, that's certainly better,
>
> Thanks,

OK, so an amended one will look like this?

-- >8 --
From: Antoine Pelisse <apelisse@gmail.com>
Subject: remote-hg: unquote C-style paths when exporting

git-fast-import documentation says that paths can be C-style quoted.
Unfortunately, the current remote-hg helper doesn't unquote quoted
path and pass them as-is to Mercurial when the commit is created.

This result in the following situation:

- clone a mercurial repository with git
- Add a file with space: `mkdir dir/foo\ bar`
- Commit that new file, and push the change to mercurial
- The mercurial repository as now a new directory named '"dir', which
contains a file named 'foo bar"'

Use python ast.literal_eval to unquote the string if it starts with ".
It has been tested with quotes, spaces, and utf-8 encoded file-names.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 contrib/remote-helpers/git-remote-hg | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0194c67..85abbed 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -678,6 +678,11 @@ def get_merge_files(repo, p1, p2, files):
             f = { 'ctx' : repo[p1][e] }
             files[e] = f
 
+def c_style_unescape(string):
+    if string[0] == string[-1] == '"':
+        return string.decode('string-escape')[1:-1]
+    return string
+
 def parse_commit(parser):
     global marks, blob_marks, parsed_refs
     global mode
@@ -720,6 +725,7 @@ def parse_commit(parser):
             f = { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
+        path = c_style_unescape(path).decode('utf-8')
         files[path] = f
 
     # only export the commits if we are on an internal proxy repo
