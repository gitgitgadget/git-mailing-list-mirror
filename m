From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: Re: encoding bug in git.el
Date: Wed, 21 May 2008 23:08:09 +0900
Message-ID: <1f748ec60805210708q34a26bebh915037713caa9a87@mail.gmail.com>
References: <20080520220900.GA20570@diana.vm.bytemark.co.uk>
	 <87mymkbo9x.fsf@lysator.liu.se>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed May 21 16:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyp04-0004hv-Dv
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 16:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764976AbYEUOIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 10:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764431AbYEUOIM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 10:08:12 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:25419 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763949AbYEUOIL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 10:08:11 -0400
Received: by an-out-0708.google.com with SMTP id d40so669002and.103
        for <git@vger.kernel.org>; Wed, 21 May 2008 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=dAYjR23DFU8ivI5rGP0wqhy2V0hHiYN2xYt7dySzA4k=;
        b=Qy8EK7adRDM5C2SfDTy20jb8Ar0oQc02Gb34Fi7H1VONh/vFirCuGwJmLFMqvNVxJnqvXMARxv/sfHuN39v7gNj2jS4sKXaPUp1DQ1GrwdXra+iprS2f3i9L/DBUFmTx8YDL7FmrV9provrzn19FdVYnYyelJCr8nESovD7WiDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KYNUv4yE6XVWn7n6NlhK323Dx0cg3/1S6hqunRXSsRMMEtpkj0WZm3tOGTU9acOKpbDtY2Bh40XJx0lGLS5MwwGLWwnllzdLXKx23AZzvFK8v8ghvjBblpaEOjzmQchU0nAp6Vkiaj4G9JsxlZl8e5CbY1vIw2tADkT/S0O1xyM=
Received: by 10.100.201.16 with SMTP id y16mr416574anf.26.1211378889957;
        Wed, 21 May 2008 07:08:09 -0700 (PDT)
Received: by 10.101.1.13 with HTTP; Wed, 21 May 2008 07:08:09 -0700 (PDT)
In-Reply-To: <87mymkbo9x.fsf@lysator.liu.se>
Content-Disposition: inline
X-Google-Sender-Auth: acb35c74ca7f88b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82544>

Hi:

On Wed, May 21, 2008 at 7:31 AM, David K=E5gedal <davidk@lysator.liu.se=
> wrote:
> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
>> Recently, some commits started misrecording the "=F6" in my name. (I=
n
>> emacs, for example, it looks like this in a utf8 buffer:
>> Hasselstr\201\366m.) I'm guessing there's an extra latin1->utf8
>> conversion in there somewhere.
>
> The \201 looks more like Emacs' internal mule encoding, where
> everything that isn't ASCII is prefixed with \201 or something
> similar.

Thanks for reporting this.

I concur. This is not UTF-8 translation, but an emacs MULE encoding. I
suspect the U+F6 character is read in to the *git-commit* buffer in
latin-1 mode because git.el displays the Author line, then Emacs
writes that out as 0x81F6, because that is the emacs buffer code of
U+F6.

This is because git.el, upon git-commit-tree, always redefines the
environment variables like GIT_AUTHOR_NAME. However the difference is
that prior to commit dbe482, "env" handle the encoding while commit
dbe482 lets emacs process-environment handle it. Unfortunately the
string is passed without the proper recoding in the latter case.

Here is a proposed fix. I suggest that process-environment should be
given these envvars already encoded as shown in this code sample:

------------------ git.el ------------------
[not a proper git-diff]
@@ -216,6 +216,11 @@ and `git-diff-setup-hook'."
   "Build a list of NAME=3DVALUE strings from a list of environment str=
ings."
   (mapcar (lambda (entry) (concat (car entry) "=3D" (cdr entry))) env)=
)

+(defun git-get-env-strings-encoded (env encoding)
+  "Build a list of NAME=3DVALUE strings from a list of environment str=
ings,
+converting from mule-encoding to ENCODING (e.g. mule-utf-8, latin-1, e=
tc)."
+  (mapcar (lambda (entry) (concat (car entry) "=3D"
(encode-coding-string (cdr entry) encoding))) env))
+
 (defun git-call-process-env (buffer env &rest args)
   "Wrapper for call-process that sets environment strings."
   (let ((process-environment (append (git-get-env-strings env)
@@ -265,7 +270,7 @@ and returns the process output as a string, or nil
if the git failed."

 (defun git-run-command-region (buffer start end env &rest args)
   "Run a git command with specified buffer region as input."
-  (unless (eq 0 (let ((process-environment (append (git-get-env-string=
s env)
+  (unless (eq 0 (let ((process-environment (append
(git-get-env-strings-encoded env coding-system-for-write)
                                                    process-environment=
)))
                   (git-run-process-region
                    buffer start end "git" args)))

The buffer text is saved with the encoding coding-system-for-write,
while the GIT_* envvars were not encoded, so when appending to
process-environment variable, use the same encoding.

(Reminder: the *git-commit* buffer's encoding is based on the git
config i18n.commitencoding, which in turn sets
buffer-file-coding-system, which in turn sets coding-system-for-write)

I tested this with U+F6 in the GIT_AUTHOR_NAME, git config user.name,
and the commit text, and it seems to work better (I think it's fixed).
Please review it. Also, I am not sure if this fix needs to be
propagated to the other areas where process-environment is redefined,
so YMMV.

(Lastly, while testing this for Japanese, I'm having some encoding
problem with meadow (Emacs on Windows), msysgit (git on Windows),
set-language-mode Japanese, utf-8, and M-x git-commit-file but I don't
think its related to this exact problem. Hopefully.)

>> It turns out that the breakage occurs when I commit with the
>> git-status mode from git.el, and it was introduced by this commit:
>>
>>   commit dbe48256b41c1e94d81f2458d7e84b1fdcb47026
>>   Author: Clifford Caoile <piyo@users.sourceforge.net>
>>
>>       git.el: Set process-environment instead of invoking env

:-)

This must be the reason why process-environment wasn't used in all plac=
es.

>> It's in master, but not yet in maint. (In fact, it's the _only_ chan=
ge
>> to contrib/emacs that's in master but not in maint.)

Please forgive my ignorance, but what does this mean?

Best regards,
Clifford Caoile
