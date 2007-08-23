From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 11:19:12 +0100
Message-ID: <b0943d9e0708230319m3242f4a7yb4db1505f0d2e3@mail.gmail.com>
References: <20070823092254.GA5976@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_100246_1321457.1187864352017"
Cc: git@vger.kernel.org
To: "Greg KH" <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 12:19:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO9mY-0005BS-Vx
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 12:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758145AbXHWKTP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 06:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbXHWKTP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 06:19:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:37115 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757887AbXHWKTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 06:19:14 -0400
Received: by nf-out-0910.google.com with SMTP id g13so336450nfb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 03:19:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=aivRuCWjT3S91HG3wtc/nHEjT2COY4aotCaRfXbCF5XKpdjhdOMu4NMu2mHuh254VxOhugoDIoQ9bnqKITIUPe5+g4LdvXrwUnybgnZbXT74XwSBxHMrVLho2n9jUWPueVQwPgOw4VDAp7k5gMHl3W2uxMNHjlo5JomMfLGZmcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=APBH6U6BmdadwdGUyrfeoAsPdEk6TSvE97LSnjBls3taQ/vUrM9BAYiVGGPSkUgeY3NKOVXaHnDDFHWqlwzv3w/pqUvRgObmQcl0GCoOnc17UfYU2LIa0ANssoHwtnQJyNmBZjID+4HyfV++M0uKabS/0cdvKJpstqHiW48l5Dw=
Received: by 10.78.170.6 with SMTP id s6mr1094325hue.1187864352042;
        Thu, 23 Aug 2007 03:19:12 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Thu, 23 Aug 2007 03:19:12 -0700 (PDT)
In-Reply-To: <20070823092254.GA5976@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56488>

------=_Part_100246_1321457.1187864352017
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 23/08/07, Greg KH <greg@kroah.com> wrote:
> I wanted to see if I could start using stgit instead of quilt, so I
> tried to import my current set of kernel patches.
>
> After giving up on the "import a series" option,

Why?

> I just created a mbox
> of all of them using quilt and tried to import that.  Unfortunately that
> didn't work either:
>         $ stg import -M ~/linux/patches/mbox
>         Checking for changes in the working directory ... done
>         Importing patch "add-my-version-to-the-kernel" ... done
>         Importing patch "stupid-patch-for-my-laptop-whi" ... done
>         Importing patch "gregs-test-driver-core-sysfs-s" ... done
>         Importing patch "detect-atomic-counter-underflo" ... done
>         Warning: Message does not contain any diff
>         stg import: No diff found inside the patch

Maybe I should just leave the warning and let it continue. The reason
I added it was that "git-apply --index" fails if there is no diff.

In the meantime, you can try the attached patch for StGIT.

Another hint - quilt can apply patches with fuzz but GIT doesn't allow
this by default. If a patch fails, the diff is dumped to the
.stgit-failed.patch file so that you can apply it manually (with patch
or git-apply) and run 'stg refresh' afterwards.

After an import failure, you can continue importing from the next
patch using the 'stg import --ignore' option.

> I'm using the .13 version if that matters.
>
> The mbox contains 177 kernel patches against Linus's current tree
> (2.6.23-rc3-git5), and is available at:
>         http://www.kernel.org/pub/linux/kernel/people/gregkh/misc/gregkh-stgit-import-mbox.gz
> if anyone wants to test it out and see what I was doing wrong.

I'll give it a try.

One thing you'll notice is the speed difference as stgit has to
generate a git commit during a push operation.

> Oh, I do have some suggestions as to the naming of the patch from a mail
> file, as limiting this to a small number of characters like stgit
> currently does will not work out for a lot of my patches, but I'll wait
> until I can actually import the thing before I look into that :)

We had the full name in the past but the algorithm cause problems with
patches (not e-mails) that didn't have a subject line. It's probably
better to have a config option rather than hard-coded 30 characters.
Note that 'stg series -d' will display the full subject line.

If you don't give up before importing the files :-), please let us
know the user experience, especially related to speed as compared to
quilt.

Karl, maybe it's worth trying this series with your DAG patches as well.

Regards.

-- 
Catalin

------=_Part_100246_1321457.1187864352017
Content-Type: text/x-patch; name=import-empty.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f5p3i6sk
Content-Disposition: attachment; filename="import-empty.patch"

QWxsb3cgJ2ltcG9ydCcgdG8gYXBwbHkgZW1wdHkgcGF0Y2hlcwoKRnJvbTogQ2F0YWxpbiBNYXJp
bmFzIDxjYXRhbGluLm1hcmluYXNAZ21haWwuY29tPgoKU2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBN
YXJpbmFzIDxjYXRhbGluLm1hcmluYXNAZ21haWwuY29tPgotLS0KCiBzdGdpdC9jb21tYW5kcy9p
bXBydC5weSB8ICAgMjIgKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zdGdpdC9jb21t
YW5kcy9pbXBydC5weSBiL3N0Z2l0L2NvbW1hbmRzL2ltcHJ0LnB5CmluZGV4IGY5NzJiODkuLjk4
ZmU3MDggMTAwNjQ0Ci0tLSBhL3N0Z2l0L2NvbW1hbmRzL2ltcHJ0LnB5CisrKyBiL3N0Z2l0L2Nv
bW1hbmRzL2ltcHJ0LnB5CkBAIC0yMDEsOCArMjAxLDYgQEAgZGVmIF9fcGFyc2VfbWFpbChtc2cp
OgogICAgIHJlbV9kZXNjciwgZGlmZiA9IF9fc3BsaXRfZGVzY3JfZGlmZihtc2dfdGV4dCkKICAg
ICBpZiByZW1fZGVzY3I6CiAgICAgICAgIGRlc2NyICs9ICdcblxuJyArIHJlbV9kZXNjcgotICAg
IGlmIG5vdCBkaWZmOgotICAgICAgICBvdXQud2FybignTWVzc2FnZSBkb2VzIG5vdCBjb250YWlu
IGFueSBkaWZmJykKIAogICAgICMgcGFyc2UgdGhlIGRlc2NyaXB0aW9uIGZvciBhdXRob3IgaW5m
b3JtYXRpb24KICAgICBkZXNjciwgZGVzY3JfYXV0aG5hbWUsIGRlc2NyX2F1dGhlbWFpbCwgZGVz
Y3JfYXV0aGRhdGUgPSBcCkBAIC0yNTAsOSArMjQ4LDYgQEAgZGVmIF9fY3JlYXRlX3BhdGNoKGZp
bGVuYW1lLCBtZXNzYWdlLCBhdXRob3JfbmFtZSwgYXV0aG9yX2VtYWlsLAogICAgICAgICAjIGZp
eCBwb3NzaWJsZSBpbnZhbGlkIGNoYXJhY3RlcnMgaW4gdGhlIHBhdGNoIG5hbWUKICAgICAgICAg
cGF0Y2ggPSByZS5zdWIoJ1teXHcuXSsnLCAnLScsIHBhdGNoKS5zdHJpcCgnLScpCiAKLSAgICBp
ZiBub3QgZGlmZjoKLSAgICAgICAgcmFpc2UgQ21kRXhjZXB0aW9uLCAnTm8gZGlmZiBmb3VuZCBp
bnNpZGUgdGhlIHBhdGNoJwotCiAgICAgaWYgb3B0aW9ucy5pZ25vcmUgYW5kIHBhdGNoIGluIGNy
dF9zZXJpZXMuZ2V0X2FwcGxpZWQoKToKICAgICAgICAgb3V0LmluZm8oJ0lnbm9yaW5nIGFscmVh
ZHkgYXBwbGllZCBwYXRjaCAiJXMiJyAlIHBhdGNoKQogICAgICAgICByZXR1cm4KQEAgLTI4OCwx
NCArMjgzLDE3IEBAIGRlZiBfX2NyZWF0ZV9wYXRjaChmaWxlbmFtZSwgbWVzc2FnZSwgYXV0aG9y
X25hbWUsIGF1dGhvcl9lbWFpbCwKICAgICAgICAgICAgICAgICAgICAgICAgICBjb21taXR0ZXJf
bmFtZSA9IGNvbW1pdHRlcl9uYW1lLAogICAgICAgICAgICAgICAgICAgICAgICAgIGNvbW1pdHRl
cl9lbWFpbCA9IGNvbW1pdHRlcl9lbWFpbCkKIAotICAgIG91dC5zdGFydCgnSW1wb3J0aW5nIHBh
dGNoICIlcyInICUgcGF0Y2gpCi0gICAgaWYgb3B0aW9ucy5iYXNlOgotICAgICAgICBnaXQuYXBw
bHlfcGF0Y2goZGlmZiA9IGRpZmYsIGJhc2UgPSBnaXRfaWQob3B0aW9ucy5iYXNlKSkKKyAgICBp
ZiBub3QgZGlmZjoKKyAgICAgICAgb3V0Lndhcm4oJ05vIGRpZmYgZm91bmQsIGNyZWF0aW5nIGVt
cHR5IHBhdGNoJykKICAgICBlbHNlOgotICAgICAgICBnaXQuYXBwbHlfcGF0Y2goZGlmZiA9IGRp
ZmYpCi0gICAgY3J0X3Nlcmllcy5yZWZyZXNoX3BhdGNoKGVkaXQgPSBvcHRpb25zLmVkaXQsCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNob3dfcGF0Y2ggPSBvcHRpb25zLnNob3dwYXRj
aCkKLSAgICBvdXQuZG9uZSgpCisgICAgICAgIG91dC5zdGFydCgnSW1wb3J0aW5nIHBhdGNoICIl
cyInICUgcGF0Y2gpCisgICAgICAgIGlmIG9wdGlvbnMuYmFzZToKKyAgICAgICAgICAgIGdpdC5h
cHBseV9wYXRjaChkaWZmID0gZGlmZiwgYmFzZSA9IGdpdF9pZChvcHRpb25zLmJhc2UpKQorICAg
ICAgICBlbHNlOgorICAgICAgICAgICAgZ2l0LmFwcGx5X3BhdGNoKGRpZmYgPSBkaWZmKQorICAg
ICAgICBjcnRfc2VyaWVzLnJlZnJlc2hfcGF0Y2goZWRpdCA9IG9wdGlvbnMuZWRpdCwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNob3dfcGF0Y2ggPSBvcHRpb25zLnNob3dwYXRj
aCkKKyAgICAgICAgb3V0LmRvbmUoKQogCiBkZWYgX19pbXBvcnRfZmlsZShmaWxlbmFtZSwgb3B0
aW9ucywgcGF0Y2ggPSBOb25lKToKICAgICAiIiJJbXBvcnQgYSBwYXRjaCBmcm9tIGEgZmlsZSBv
ciBzdGFuZGFyZCBpbnB1dAo=
------=_Part_100246_1321457.1187864352017--
