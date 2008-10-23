From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Only update the cygwin-related configuration during state auto-setup
Date: Thu, 23 Oct 2008 15:07:22 +0200
Message-ID: <81b0412b0810230607sfea05ddm62bd03f837fc922e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30609_22722052.1224767242325"
Cc: gitster@pobox.com, spearce@spearce.org, dpotapov@gmail.com,
	git@vger.kernel.org
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 15:08:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KszvZ-0004ni-8f
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 15:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYJWNHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 09:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYJWNHY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 09:07:24 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:18470 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYJWNHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 09:07:23 -0400
Received: by an-out-0708.google.com with SMTP id d40so22000and.103
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type;
        bh=UBaVHRg4MD3ZIf9NGn8V9AD7OIyf2PJZByioIGIn0mU=;
        b=IcWdNz3uXjlpwgtg4NVdQtSwZdyd1TJVoT9FxIEXLxq6rygMoImHayXWskDvhZgFOe
         tgxQBjcRd4gMwLagK8fIynDl1zFd24kDTNqWiwyEeImj+fyA5OsWyTHFSQoUh+KevaYw
         jErBb0bpBUdD+YvSiP8pOFYv0RG9vJMPSEby4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=gVd4Ati4jpSAbRK10L3fNol0aaGI9ETdaJMhMSU1IEmD6K1Zpxgy3YW9pbDT0z36XA
         wh8dfTRRJ8qHTY6t4CJDooKhsn4z3NpQxxczYUV7i84hpGqdYg+nymRm52LvVobsfR+P
         PKsn3uf2tVXFMolDbdKC6ildQRn2FWrGNY49U=
Received: by 10.100.197.3 with SMTP id u3mr432087anf.64.1224767242329;
        Thu, 23 Oct 2008 06:07:22 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Thu, 23 Oct 2008 06:07:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98962>

------=_Part_30609_22722052.1224767242325
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise the other global settings which were already read and set up will
be overwritten because the auto-setup code can be called really late in
game.  For instance, t3901-i18n-patch and --encoding=something of revision
argument parser are actually broken at the moment. The parser
(handle_revision_opt) sets git_log_output_encoding, which is also updated
(or in this case - overwritten) in the default config handler.

The code still has the problem if someone loads the configuration,
sets trust_executable_bit according to other conditions (a future
command-line option, perhaps) and than causes the init_stat call.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 compat/cygwin.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

2008/10/13 Mark Levedahl <mlevedahl@gmail.com>:
>  static int git_cygwin_config(const char *var, const char *value, void *cb)
>  {
> -       if (!strcmp(var, "core.ignorecygwinfstricks"))
> -               native_stat = git_config_bool(var, value);
> -       return 0;
> +       if (!strcmp(var, "core.ignorecygwinfstricks")) {
> +                       native_stat = git_config_bool(var, value);
> +                       return 0;
> +       }
> +       return git_default_config(var, value, cb);
>  }

This actually breaks t3901-i18n-patch (and --encoding=something of
revision argument parser). The parser (handle_revision_opt) sets
git_log_output_encoding, which is also updated (or in this case - overwritten)
in the default config handler.

------=_Part_30609_22722052.1224767242325
Content-Type: application/xxxxx;
 name=0001-Only-update-the-cygwin-related-configuration-during.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmnet73t0
Content-Disposition: attachment;
 filename=0001-Only-update-the-cygwin-related-configuration-during.patch

RnJvbSAxMDBjYWYyYmRhMjhiMDJkNmE1YWNkNDYwYWYyNjY0OWQ1MzNlMTUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDIzIE9jdCAyMDA4IDE0OjQ3OjI1ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gT25seSB1
cGRhdGUgdGhlIGN5Z3dpbi1yZWxhdGVkIGNvbmZpZ3VyYXRpb24gZHVyaW5nIHN0YXRlIGF1dG8t
c2V0dXAKCk90aGVyd2lzZSB0aGUgb3RoZXIgZ2xvYmFsIHNldHRpbmdzIHdoaWNoIHdlcmUgYWxy
ZWFkeSByZWFkIGFuZCBzZXQgdXAgd2lsbApiZSBvdmVyd3JpdHRlbiBiZWNhdXNlIHRoZSBhdXRv
LXNldHVwIGNvZGUgY2FuIGJlIGNhbGxlZCByZWFsbHkgbGF0ZSBpbgpnYW1lLiAgRm9yIGluc3Rh
bmNlLCB0MzkwMS1pMThuLXBhdGNoIGFuZCAtLWVuY29kaW5nPXNvbWV0aGluZyBvZiByZXZpc2lv
bgphcmd1bWVudCBwYXJzZXIgYXJlIGFjdHVhbGx5IGJyb2tlbiBhdCB0aGUgbW9tZW50LiBUaGUg
cGFyc2VyCihoYW5kbGVfcmV2aXNpb25fb3B0KSBzZXRzIGdpdF9sb2dfb3V0cHV0X2VuY29kaW5n
LCB3aGljaCBpcyBhbHNvIHVwZGF0ZWQKKG9yIGluIHRoaXMgY2FzZSAtIG92ZXJ3cml0dGVuKSBp
biB0aGUgZGVmYXVsdCBjb25maWcgaGFuZGxlci4KClRoZSBjb2RlIHN0aWxsIGhhcyB0aGUgcHJv
YmxlbSBpZiBzb21lb25lIGxvYWRzIHRoZSBjb25maWd1cmF0aW9uLApzZXRzIHRydXN0X2V4ZWN1
dGFibGVfYml0IGFjY29yZGluZyB0byBvdGhlciBjb25kaXRpb25zIChhIGZ1dHVyZQpjb21tYW5k
LWxpbmUgb3B0aW9uLCBwZXJoYXBzKSBhbmQgdGhhbiBjYXVzZXMgdGhlIGluaXRfc3RhdCBjYWxs
LgoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBj
b21wYXQvY3lnd2luLmMgfCAgICA5ICsrKysrLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvY29tcGF0L2N5Z3dpbi5jIGIv
Y29tcGF0L2N5Z3dpbi5jCmluZGV4IGYxOTY3NTMuLmIzZmFlNTMgMTAwNjQ0Ci0tLSBhL2NvbXBh
dC9jeWd3aW4uYworKysgYi9jb21wYXQvY3lnd2luLmMKQEAgLTk5LDExICs5OSwxMiBAQCBleHRl
cm4gaW50IHRydXN0X2V4ZWN1dGFibGVfYml0OwogCiBzdGF0aWMgaW50IGdpdF9jeWd3aW5fY29u
ZmlnKGNvbnN0IGNoYXIgKnZhciwgY29uc3QgY2hhciAqdmFsdWUsIHZvaWQgKmNiKQogewotCWlm
ICghc3RyY21wKHZhciwgImNvcmUuaWdub3JlY3lnd2luZnN0cmlja3MiKSkgeworCS8qIG1ha2Ug
c3VyZSB0cnVzdF9leGVjdXRhYmxlX2JpdCBpcyB1cGRhdGVkIHByb3Blcmx5ICovCisJaWYgKCFz
dHJjbXAodmFyLCAiY29yZS5maWxlbW9kZSIpKQorCQlyZXR1cm4gZ2l0X2RlZmF1bHRfY29uZmln
KHZhciwgdmFsdWUsIGNiKTsKKwlpZiAoIXN0cmNtcCh2YXIsICJjb3JlLmlnbm9yZWN5Z3dpbmZz
dHJpY2tzIikpCiAJCW5hdGl2ZV9zdGF0ID0gZ2l0X2NvbmZpZ19ib29sKHZhciwgdmFsdWUpOwot
CQlyZXR1cm4gMDsKLQl9Ci0JcmV0dXJuIGdpdF9kZWZhdWx0X2NvbmZpZyh2YXIsIHZhbHVlLCBj
Yik7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgaW5pdF9zdGF0KHZvaWQpCi0tIAoxLjYu
MC4yLjU2Ni5nNmQ0MWMKCg==
------=_Part_30609_22722052.1224767242325--
