From: Brad Roberts <braddr@puremagic.com>
Subject: active_cache leaks
Date: Sun, 17 Apr 2005 00:07:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504162358130.2625-200000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1110348602-430216159-1113721626=:2625"
X-From: git-owner@vger.kernel.org Sun Apr 17 09:04:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN3p1-0004EE-Ry
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 09:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVDQHH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 03:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVDQHH2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 03:07:28 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:11490 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261276AbVDQHHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 03:07:10 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3H777O1026466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 00:07:07 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3H776o5026462
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 00:07:07 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1110348602-430216159-1113721626=:2625
Content-Type: TEXT/PLAIN; charset=US-ASCII

Ok.. so there's been a couple attempts to patch the leak that were all
wrong due to mixed memory management for that array.  Here's a seed for
discussion on how to plug that leak.  Some would argue that it's not
leaking enough to fix, but for those that want to turn git into a library,
the lifetime of the cache could end up not being short any more, so it's
worth discussing how to fix it.

The q&d fix in this patch isn't elegant, but gets the job done.  More
interesting could be to have the entry itself contain a state bit, though
that wastes storage space.

Two basic changes:

1) introduce a set_active_cache() api and change all 'active_cache[i] = ce'
   calls to use it.
2) add a active_cache_malloced array to parallel the active_cache array.

I don't like #2, but see that q&d comment. :)

It's only lightly tested as I'm still trying to wrap my head around how to
actually use git and git-pasky.

I was tempted to add a get_cache_entry api as well, so that nothing
outside of read-cache.c touched active_cache directly, but that can come
next.

Later,
Brad


---1110348602-430216159-1113721626=:2625
Content-Type: TEXT/plain; name="git-active-cache-leak.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0504170007060.2625@bellevue.puremagic.com>
Content-Description: git-active-cache-leak.diff
Content-Disposition: attachment; filename="git-active-cache-leak.diff"

LS0tIGNhY2hlLmgNCisrKyBjYWNoZS5oCTIwMDUtMDQtMTYgMjM6MDg6Mzcu
MDAwMDAwMDAwIC0wNzAwDQpAQCAtODgsNiArODgsNyBAQA0KIGV4dGVybiBp
bnQgcmVhZF9jYWNoZSh2b2lkKTsNCiBleHRlcm4gaW50IHdyaXRlX2NhY2hl
KGludCBuZXdmZCwgc3RydWN0IGNhY2hlX2VudHJ5ICoqY2FjaGUsIGludCBl
bnRyaWVzKTsNCiBleHRlcm4gaW50IGNhY2hlX25hbWVfcG9zKGNvbnN0IGNo
YXIgKm5hbWUsIGludCBuYW1lbGVuKTsNCitleHRlcm4gaW50IHNldF9jYWNo
ZV9lbnRyeShzdHJ1Y3QgY2FjaGVfZW50cnkgKmNlLCBpbnQgcG9zLCBpbnQg
bWFsbG9jZWRfZW50cnkpOw0KIGV4dGVybiBpbnQgYWRkX2NhY2hlX2VudHJ5
KHN0cnVjdCBjYWNoZV9lbnRyeSAqY2UsIGludCBva190b19hZGQpOw0KIGV4
dGVybiBpbnQgcmVtb3ZlX2ZpbGVfZnJvbV9jYWNoZShjaGFyICpwYXRoKTsN
CiBleHRlcm4gaW50IGNhY2hlX21hdGNoX3N0YXQoc3RydWN0IGNhY2hlX2Vu
dHJ5ICpjZSwgc3RydWN0IHN0YXQgKnN0KTsNCi0tLSByZWFkLWNhY2hlLmMN
CisrKyByZWFkLWNhY2hlLmMJMjAwNS0wNC0xNiAyMzozMjozNC4wMDAwMDAw
MDAgLTA3MDANCkBAIC04LDYgKzgsNyBAQA0KIA0KIGNvbnN0IGNoYXIgKnNo
YTFfZmlsZV9kaXJlY3RvcnkgPSBOVUxMOw0KIHN0cnVjdCBjYWNoZV9lbnRy
eSAqKmFjdGl2ZV9jYWNoZSA9IE5VTEw7DQorc3RhdGljIGludCAqIGFjdGl2
ZV9jYWNoZV9tYWxsb2NlZCA9IE5VTEw7DQogdW5zaWduZWQgaW50IGFjdGl2
ZV9uciA9IDAsIGFjdGl2ZV9hbGxvYyA9IDA7DQogDQogdm9pZCB1c2FnZShj
b25zdCBjaGFyICplcnIpDQpAQCAtMzgxLDYgKzM4MiwxNSBAQA0KIAlyZXR1
cm4gY2VfbmFtZWxlbihiKSA9PSBsZW4gJiYgIW1lbWNtcChhLT5uYW1lLCBi
LT5uYW1lLCBsZW4pOw0KIH0NCiANCitpbnQgc2V0X2NhY2hlX2VudHJ5KHN0
cnVjdCBjYWNoZV9lbnRyeSAqY2UsIGludCBwb3MsIGludCBtYWxsb2NlZF9l
bnRyeSkNCit7DQorCWlmIChhY3RpdmVfY2FjaGVfbWFsbG9jZWRbcG9zXSkN
CisJCWZyZWUoYWN0aXZlX2NhY2hlW3Bvc10pOw0KKwlhY3RpdmVfY2FjaGVb
cG9zXSA9IGNlOw0KKwlhY3RpdmVfY2FjaGVfbWFsbG9jZWRbcG9zXSA9IG1h
bGxvY2VkX2VudHJ5Ow0KKwlyZXR1cm4gMDsNCit9DQorDQogaW50IGFkZF9j
YWNoZV9lbnRyeShzdHJ1Y3QgY2FjaGVfZW50cnkgKmNlLCBpbnQgb2tfdG9f
YWRkKQ0KIHsNCiAJaW50IHBvczsNCkBAIC0zODksNyArMzk5LDcgQEANCiAN
CiAJLyogZXhpc3RpbmcgbWF0Y2g/IEp1c3QgcmVwbGFjZSBpdCAqLw0KIAlp
ZiAocG9zID49IDApIHsNCi0JCWFjdGl2ZV9jYWNoZVtwb3NdID0gY2U7DQor
CQlzZXRfY2FjaGVfZW50cnkoY2UsIHBvcywgMCk7DQogCQlyZXR1cm4gMDsN
CiAJfQ0KIAlwb3MgPSAtcG9zLTE7DQpAQCAtNDE0LDEzICs0MjQsMTYgQEAN
CiAJaWYgKGFjdGl2ZV9uciA9PSBhY3RpdmVfYWxsb2MpIHsNCiAJCWFjdGl2
ZV9hbGxvYyA9IGFsbG9jX25yKGFjdGl2ZV9hbGxvYyk7DQogCQlhY3RpdmVf
Y2FjaGUgPSByZWFsbG9jKGFjdGl2ZV9jYWNoZSwgYWN0aXZlX2FsbG9jICog
c2l6ZW9mKHN0cnVjdCBjYWNoZV9lbnRyeSAqKSk7DQorCQlhY3RpdmVfY2Fj
aGVfbWFsbG9jZWQgPSByZWFsbG9jKGFjdGl2ZV9jYWNoZSwgYWN0aXZlX2Fs
bG9jICogc2l6ZW9mKGludCkpOw0KIAl9DQogDQogCS8qIEFkZCBpdCBpbi4u
ICovDQogCWFjdGl2ZV9ucisrOw0KLQlpZiAoYWN0aXZlX25yID4gcG9zKQ0K
KwlpZiAoYWN0aXZlX25yID4gcG9zKSB7DQogCQltZW1tb3ZlKGFjdGl2ZV9j
YWNoZSArIHBvcyArIDEsIGFjdGl2ZV9jYWNoZSArIHBvcywgKGFjdGl2ZV9u
ciAtIHBvcyAtIDEpICogc2l6ZW9mKGNlKSk7DQotCWFjdGl2ZV9jYWNoZVtw
b3NdID0gY2U7DQorCQltZW1tb3ZlKGFjdGl2ZV9jYWNoZV9tYWxsb2NlZCAr
IHBvcyArIDEsIGFjdGl2ZV9jYWNoZV9tYWxsb2NlZCArIHBvcywgKGFjdGl2
ZV9uciAtIHBvcyAtIDEpICogc2l6ZW9mKGludCkpOw0KKwl9DQorCXNldF9j
YWNoZV9lbnRyeShjZSwgcG9zLCAxKTsNCiAJcmV0dXJuIDA7DQogfQ0KIA0K
QEAgLTQ4MiwxMiArNDk1LDEzIEBADQogCWFjdGl2ZV9uciA9IG50b2hsKGhk
ci0+aGRyX2VudHJpZXMpOw0KIAlhY3RpdmVfYWxsb2MgPSBhbGxvY19ucihh
Y3RpdmVfbnIpOw0KIAlhY3RpdmVfY2FjaGUgPSBjYWxsb2MoYWN0aXZlX2Fs
bG9jLCBzaXplb2Yoc3RydWN0IGNhY2hlX2VudHJ5ICopKTsNCisJYWN0aXZl
X2NhY2hlX21hbGxvY2VkID0gY2FsbG9jKGFjdGl2ZV9hbGxvYywgc2l6ZW9m
KGludCkpOw0KIA0KIAlvZmZzZXQgPSBzaXplb2YoKmhkcik7DQogCWZvciAo
aSA9IDA7IGkgPCBhY3RpdmVfbnI7IGkrKykgew0KIAkJc3RydWN0IGNhY2hl
X2VudHJ5ICpjZSA9IG1hcCArIG9mZnNldDsNCiAJCW9mZnNldCA9IG9mZnNl
dCArIGNlX3NpemUoY2UpOw0KLQkJYWN0aXZlX2NhY2hlW2ldID0gY2U7DQor
CQlzZXRfY2FjaGVfZW50cnkoY2UsIGksIDApOw0KIAl9DQogCXJldHVybiBh
Y3RpdmVfbnI7DQogDQotLS0gdXBkYXRlLWNhY2hlLmMNCisrKyB1cGRhdGUt
Y2FjaGUuYwkyMDA1LTA0LTE2IDIzOjMzOjI4LjAwMDAwMDAwMCAtMDcwMA0K
QEAgLTE5OSwxMSArMTk5LDE0IEBADQogCQlzdHJ1Y3QgY2FjaGVfZW50cnkg
KmNlID0gYWN0aXZlX2NhY2hlW2ldOw0KIAkJc3RydWN0IGNhY2hlX2VudHJ5
ICpuZXcgPSByZWZyZXNoX2VudHJ5KGNlKTsNCiANCisJCWlmIChuZXcgPT0g
Y2UpDQorCQkJY29udGludWU7DQorDQogCQlpZiAoIW5ldykgew0KIAkJCXBy
aW50ZigiJXM6IG5lZWRzIHVwZGF0ZVxuIiwgY2UtPm5hbWUpOw0KIAkJCWNv
bnRpbnVlOw0KIAkJfQ0KLQkJYWN0aXZlX2NhY2hlW2ldID0gbmV3Ow0KKwkJ
c2V0X2NhY2hlX2VudHJ5KG5ldywgaSwgMSk7DQogCX0NCiB9DQogDQo=
---1110348602-430216159-1113721626=:2625--
