From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Merging limitations after directory renames -- interesting test repo
Date: Fri, 18 Feb 2011 16:26:14 -0800
Message-ID: <AANLkTimuU4A7sUqo-dpW3ch4H_WJg+G2ynNmagx=C9t8@mail.gmail.com>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net> <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00221534d727d84eb8049c97aea5
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 01:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqaen-00015k-EA
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 01:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab1BSA0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 19:26:37 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34693 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753509Ab1BSA0f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 19:26:35 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p1J0QYse010635
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 16:26:34 -0800
Received: by iwn9 with SMTP id 9so4185721iwn.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 16:26:34 -0800 (PST)
Received: by 10.231.19.136 with SMTP id a8mr989042ibb.73.1298075194248; Fri,
 18 Feb 2011 16:26:34 -0800 (PST)
Received: by 10.231.16.129 with HTTP; Fri, 18 Feb 2011 16:26:14 -0800 (PST)
In-Reply-To: <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
X-Spam-Status: No, hits=-102.962 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167236>

--00221534d727d84eb8049c97aea5
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Feb 18, 2011 at 3:27 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We've had stupid bugs in the "diffcore_count_changes()" logic before.
> It's just that they're _usually_ hidden by overwhelming common code.
>
> In fact, the attached patch improves things a bit.

There's a secondary problem too, which is illustrated by this:

  [torvalds@i5 etherpad]$ git diff --summary -M30 $BASE.. | grep
m0024_statistics_table.js
   copy {trunk/etherpad =>
etherpad}/src/etherpad/db_migrations/m0024_statistics_table.js (100%)
   rename trunk/etherpad/src/etherpad/db_migrations/m0024_statistics_table.js
=> etherpad/src/etherpad/db_migrations/m0040_create_plugin_tables.js
(52%)

which also ends up terminally confusing the merge. It sees that dual
source of m0024_statistics_table.js and just gets really really
confused.

And the bug is that we didn't even ask for copy detection! This just
confuses merging more.

Attached is the ugliest patch ever. I'm in no way implying this should
ever be accepted, with

 - that crazy-ugly static variable to pass in the copy state to the
'for_each_hash()' callback

 - that really ugly "if (detect_rename == DIFF_DETECT_COPY)" with
broken indentation just to get rid of the copy-checking phase.

So please consider the attached patch just a "look, guys, this is
wrong, and here's the ugliest hack you've ever seen to fix it".

Anyway, with this, I can at least do

   git merge -Xrename-threshold=30 origin/pg

and while it fails miserably, the failures are now no longer "totally
obviously a git bug". Now it has real rename-rename conflicts like

CONFLICT (rename/rename): Rename
"trunk/etherpad/src/static/crossdomain.xml"->"etherpad/src/static/crossdomain.xml"
in branch "HEAD"
                          rename
"trunk/etherpad/src/static/crossdomain.xml"->"etherpad/src/static/crossdomain.xml.in"
in "origin/pg"

which really _is_ a conflict that needs user input.

Now, I didn't check that they are *all* of this valid kind, but most
of them really are. The directories are:
  (HEAD): etherpad/src/themes/default/templates
 (origin/pg): etherpad/src/templates

so you'd need to fix that up.

Whatever. It's still a nasty merge, but at least git seems to do a
much better job. That "-Xrename-threshold=30" thing is a total hack,
but it's a valid way to say "ok, git didn't find some renames I want
it to, so let's see if I can force it to do a less critical search".

                          Linus

--00221534d727d84eb8049c97aea5
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkbs2t8b1

IGRpZmZjb3JlLXJlbmFtZS5jIHwgICAxMiArKysrKysrKystLS0KIDEgZmlsZXMgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RpZmZjb3JlLXJl
bmFtZS5jIGIvZGlmZmNvcmUtcmVuYW1lLmMKaW5kZXggZGY0MWJlNS4uZGFhODVlNCAxMDA2NDQK
LS0tIGEvZGlmZmNvcmUtcmVuYW1lLmMKKysrIGIvZGlmZmNvcmUtcmVuYW1lLmMKQEAgLTE3MCw3
ICsxNzAsNyBAQCBzdGF0aWMgaW50IGVzdGltYXRlX3NpbWlsYXJpdHkoc3RydWN0IGRpZmZfZmls
ZXNwZWMgKnNyYywKIAkgKiBhbmQgdGhlIGZpbmFsIHNjb3JlIGNvbXB1dGF0aW9uIGJlbG93IHdv
dWxkIG5vdCBoYXZlIGEKIAkgKiBkaXZpZGUtYnktemVybyBpc3N1ZS4KIAkgKi8KLQlpZiAoYmFz
ZV9zaXplICogKE1BWF9TQ09SRS1taW5pbXVtX3Njb3JlKSA8IGRlbHRhX3NpemUgKiBNQVhfU0NP
UkUpCisJaWYgKG1heF9zaXplICogKE1BWF9TQ09SRS1taW5pbXVtX3Njb3JlKSA8IGRlbHRhX3Np
emUgKiBNQVhfU0NPUkUpCiAJCXJldHVybiAwOwogCiAJaWYgKCFzcmMtPmNudF9kYXRhICYmIGRp
ZmZfcG9wdWxhdGVfZmlsZXNwZWMoc3JjLCAwKSkKQEAgLTI0Niw2ICsyNDYsOCBAQCBzdHJ1Y3Qg
ZmlsZV9zaW1pbGFyaXR5IHsKIAlzdHJ1Y3QgZmlsZV9zaW1pbGFyaXR5ICpuZXh0OwogfTsKIAor
c3RhdGljIGludCBmaW5kX2NvcGllc190b287CisKIHN0YXRpYyBpbnQgZmluZF9pZGVudGljYWxf
ZmlsZXMoc3RydWN0IGZpbGVfc2ltaWxhcml0eSAqc3JjLAogCQkJCXN0cnVjdCBmaWxlX3NpbWls
YXJpdHkgKmRzdCkKIHsKQEAgLTI3Nyw2ICsyNzksOCBAQCBzdGF0aWMgaW50IGZpbmRfaWRlbnRp
Y2FsX2ZpbGVzKHN0cnVjdCBmaWxlX3NpbWlsYXJpdHkgKnNyYywKIAkJCX0KIAkJCS8qIEdpdmUg
aGlnaGVyIHNjb3JlcyB0byBzb3VyY2VzIHRoYXQgaGF2ZW4ndCBiZWVuIHVzZWQgYWxyZWFkeSAq
LwogCQkJc2NvcmUgPSAhc291cmNlLT5yZW5hbWVfdXNlZDsKKwkJCWlmIChzb3VyY2UtPnJlbmFt
ZV91c2VkICYmICFmaW5kX2NvcGllc190b28pCisJCQkJY29udGludWU7CiAJCQlzY29yZSArPSBi
YXNlbmFtZV9zYW1lKHNvdXJjZSwgdGFyZ2V0KTsKIAkJCWlmIChzY29yZSA+IGJlc3Rfc2NvcmUp
IHsKIAkJCQliZXN0ID0gcDsKQEAgLTM3NywxMSArMzgxLDEyIEBAIHN0YXRpYyB2b2lkIGluc2Vy
dF9maWxlX3RhYmxlKHN0cnVjdCBoYXNoX3RhYmxlICp0YWJsZSwgaW50IHNyY19kc3QsIGludCBp
bmRleCwKICAqIGFuZCB0aGVuIGR1cmluZyB0aGUgc2Vjb25kIHJvdW5kIHdlIHRyeSB0byBtYXRj
aAogICogY2FjaGUtZGlydHkgZW50cmllcyBhcyB3ZWxsLgogICovCi1zdGF0aWMgaW50IGZpbmRf
ZXhhY3RfcmVuYW1lcyh2b2lkKQorc3RhdGljIGludCBmaW5kX2V4YWN0X3JlbmFtZXMoaW50IGNv
cGllcykKIHsKIAlpbnQgaTsKIAlzdHJ1Y3QgaGFzaF90YWJsZSBmaWxlX3RhYmxlOwogCisJZmlu
ZF9jb3BpZXNfdG9vID0gY29waWVzOwogCWluaXRfaGFzaCgmZmlsZV90YWJsZSk7CiAJZm9yIChp
ID0gMDsgaSA8IHJlbmFtZV9zcmNfbnI7IGkrKykKIAkJaW5zZXJ0X2ZpbGVfdGFibGUoJmZpbGVf
dGFibGUsIC0xLCBpLCByZW5hbWVfc3JjW2ldLm9uZSk7CkBAIC00NjcsNyArNDcyLDcgQEAgdm9p
ZCBkaWZmY29yZV9yZW5hbWUoc3RydWN0IGRpZmZfb3B0aW9ucyAqb3B0aW9ucykKIAkgKiBXZSBy
ZWFsbHkgd2FudCB0byBjdWxsIHRoZSBjYW5kaWRhdGVzIGxpc3QgZWFybHkKIAkgKiB3aXRoIGNo
ZWFwIHRlc3RzIGluIG9yZGVyIHRvIGF2b2lkIGRvaW5nIGRlbHRhcy4KIAkgKi8KLQlyZW5hbWVf
Y291bnQgPSBmaW5kX2V4YWN0X3JlbmFtZXMoKTsKKwlyZW5hbWVfY291bnQgPSBmaW5kX2V4YWN0
X3JlbmFtZXMoZGV0ZWN0X3JlbmFtZSA9PSBESUZGX0RFVEVDVF9DT1BZKTsKIAogCS8qIERpZCB3
ZSBvbmx5IHdhbnQgZXhhY3QgcmVuYW1lcz8gKi8KIAlpZiAobWluaW11bV9zY29yZSA9PSBNQVhf
U0NPUkUpCkBAIC01NTEsNiArNTU2LDcgQEAgdm9pZCBkaWZmY29yZV9yZW5hbWUoc3RydWN0IGRp
ZmZfb3B0aW9ucyAqb3B0aW9ucykKIAkJcmVuYW1lX2NvdW50Kys7CiAJfQogCisJaWYgKGRldGVj
dF9yZW5hbWUgPT0gRElGRl9ERVRFQ1RfQ09QWSkKIAlmb3IgKGkgPSAwOyBpIDwgZHN0X2NudCAq
IE5VTV9DQU5ESURBVEVfUEVSX0RTVDsgaSsrKSB7CiAJCXN0cnVjdCBkaWZmX3JlbmFtZV9kc3Qg
KmRzdDsKIAo=
--00221534d727d84eb8049c97aea5--
