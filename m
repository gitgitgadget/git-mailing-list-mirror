From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] mail: Ask for the SMTP credentials before sending 
	the messages
Date: Mon, 1 Mar 2010 15:46:13 +0000
Message-ID: <b0943d9e1003010746l1d4208bas48fcfba36efa5605@mail.gmail.com>
References: <20100212161150.12036.62592.stgit@pc1117.cambridge.arm.com>
	 <1266015411.25535.21.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>,
	Alex Chiang <achiang@hp.com>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 16:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm7p7-0004TB-Gq
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 16:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab0CAPqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 10:46:16 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:61581 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab0CAPqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 10:46:15 -0500
Received: by fxm19 with SMTP id 19so852260fxm.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8NeDYOiSnKxehDYau5SQxTGXvReAMhXhwAQAmKZN4GA=;
        b=tx50bSTYNt/aFJTPeDrjH4HcDw3Gv8HFtg1Aa68j/wARL1q/s+pMDSH1UmeRkKORXg
         qVVDPdulL/oyY/imGs12+J6kcsNFeMjBjhR2AvTQf4GHEeeW7OCK0bfMNr9ixC3BpchI
         JRkJHvvSzmkVhNNrC5PR/MBOLwEzki19ROphs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YTc1DwlcbFJTx1zyGYE3vry55VqTi69b+UgMl3biyXVHfUFbOBB67wPUzofb5n6DVh
         KzbC8zj84JLsrpfGcKPjqhn1oRQzksRWF3bgn4DGMQDWSW5hJYzVPo1DZZrhvSo+Ajng
         f1M6ezS9UUrQGKrifQyMB/8MY1oqmUDOtN8II=
Received: by 10.223.57.133 with SMTP id c5mr5238967fah.11.1267458373765; Mon, 
	01 Mar 2010 07:46:13 -0800 (PST)
In-Reply-To: <1266015411.25535.21.camel@mj>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141325>

On 12 February 2010 22:56, Pavel Roskin <proski@gnu.org> wrote:
> On Fri, 2010-02-12 at 16:11 +0000, Catalin Marinas wrote:
>> The original implementation was asking for the SMTP password on every
>> patch sent. This patch only asks the password once before sending or
>> even editing the cover message and patches.
>
> I don't have time to investigate at the moment, but "make test" fails in
> t1900-mail.sh on the "proposed" branch, which includes this patch:

The patch was converting the message headers to Header objects rather
than strings so that the long-line folding is done using "\n " rather
than "\n\t" (Outlook cannot handle the latter correctly). But it looks
like the Python library assumes that they are strings and getting
"content-type" fails (I would say Python bug).

Anyway, I change the patch so that it only converts the the Subject
header which is the one that bothers me most:


commit 1b0c0113861681974b8905dbe10a57f6831ecb87
Author: Catalin Marinas <catalin.marinas@gmail.com>
Date:   Fri Feb 12 15:36:37 2010 +0000

    mail: Use space rather than tab for long subject header folding

    The default Python implementation (at least 2.5 and earlier) fold long
    e-mail header lines by inserting "\n\t". This causes issues with some
    e-mail clients that remove both "\n\t". The RFC2822 shows that folding
    should be done with "\n ". The Python workaround is to use a Header
    object instead of a string when setting the message headers.

    Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index d0334b4..ed55fd9 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -426,6 +426,13 @@ def __encode_message(msg):
         new_val = ' '.join(words)
         msg.replace_header(header, new_val)

+    # replace the Subject string with a Header() object otherwise the long
+    # line folding is done using "\n\t" rather than "\n ", causing issues with
+    # some e-mail clients
+    subject = msg.get('subject', '')
+    msg.replace_header('subject',
+                       email.Header.Header(subject, header_name = 'subject'))
+
     # encode the body and set the MIME and encoding headers
     if msg.is_multipart():
         for p in msg.get_payload():



-- 
Catalin
