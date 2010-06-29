From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] Convert the users for of for_each_string_list to 
	string_list_for_each
Date: Tue, 29 Jun 2010 10:37:17 +0200
Message-ID: <AANLkTimYyHtjCfRtrTgVh3LJeJQeBpdXMRsf3khKatFx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c445c1b11b5048a272586
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 10:37:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTWJs-0001wT-BK
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 10:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab0F2IhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 04:37:21 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50814 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0F2IhT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 04:37:19 -0400
Received: by ewy23 with SMTP id 23so287772ewy.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=fmk3EjnTS0BRXpAQu6CIAh3ilZJ4u8BFEIfZtEIXOqQ=;
        b=OhrwCjq/JvcbOKXG/LCiu7GzhOZButOnvyJLwHyZGxp5NwQlfWFCEG7MSp0+UdIcuC
         378jFOEwpcSdzf+8fvrgNMC5KbRPZE+j2/tsFV6YolawY74NuZDJcFonuYzrEYEFHZuN
         NAwXgyhRCMqQi3lLEMvrBv2uAg5jAfcls3BJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Z42I2stpHGsgBksmNWpAHIn96Duvap8SJkd0PORXF6CP7GC4WAcd1GW2b0U1pKnqIc
         7DPg2vc+j11YRzD0VsXfUNBOhwm4vvsfmDPg22uFqiFvabuQ5KhpfthJVEQRRM3WKpG6
         zOomjmDROIaMnjUxYAhQF1AUNDmeWIjpLuIgE=
Received: by 10.213.25.145 with SMTP id z17mr2174260ebb.29.1277800637730; Tue, 
	29 Jun 2010 01:37:17 -0700 (PDT)
Received: by 10.213.105.148 with HTTP; Tue, 29 Jun 2010 01:37:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149895>

--0015174c445c1b11b5048a272586
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The macro is suitable for all these cases and will reduce code of
need to just iterate over the items of a string list.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

> On Tue, Jun 29, 2010 at 10:33, Alex Riesen <raa.lkml@gmail.com> wrote:
>> BTW, now that I took a look at it... The iteration over string_list
>> items looks a little overengineered. At least from the point of
>> view of the existing users of the feature. Wouldn't a simple loop
>> be just as simple to use (if not simplier) and faster (no uninlineable
>> function calls and argument preparation and passing needed)?
>>
>> #define string_list_foreach(item,list) \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (item =3D (list)->items; item < (list)->i=
tems + (list)->nr; ++item)
>>

And this converts existing callers. Removes more than adds.

 notes.c        |   46 ++++++++++++++--------------------------------
 resolve-undo.c |   34 +++++++++++++++-------------------
 2 files changed, 29 insertions(+), 51 deletions(-)

diff --git a/notes.c b/notes.c
index 6ee04e7..4d5ad35 100644
--- a/notes.c
+++ b/notes.c
@@ -877,14 +877,6 @@ void string_list_add_refs_from_colon_sep(struct
string_list *list,
 	strbuf_release(&globbuf);
 }

-static int string_list_add_refs_from_list(struct string_list_item *item,
-					  void *cb)
-{
-	struct string_list *list =3D cb;
-	string_list_add_refs_by_glob(list, item->string);
-	return 0;
-}
-
 static int notes_display_config(const char *k, const char *v, void *cb)
 {
 	int *load_refs =3D cb;
@@ -947,30 +939,18 @@ void init_notes(struct notes_tree *t, const char
*notes_ref,
 	load_subtree(t, &root_tree, t->root, 0);
 }

-struct load_notes_cb_data {
-	int counter;
-	struct notes_tree **trees;
-};
-
-static int load_one_display_note_ref(struct string_list_item *item,
-				     void *cb_data)
-{
-	struct load_notes_cb_data *c =3D cb_data;
-	struct notes_tree *t =3D xcalloc(1, sizeof(struct notes_tree));
-	init_notes(t, item->string, combine_notes_ignore, 0);
-	c->trees[c->counter++] =3D t;
-	return 0;
-}
-
 struct notes_tree **load_notes_trees(struct string_list *refs)
 {
+	struct string_list_item *item;
+	int counter =3D 0;
 	struct notes_tree **trees;
-	struct load_notes_cb_data cb_data;
 	trees =3D xmalloc((refs->nr+1) * sizeof(struct notes_tree *));
-	cb_data.counter =3D 0;
-	cb_data.trees =3D trees;
-	for_each_string_list(load_one_display_note_ref, refs, &cb_data);
-	trees[cb_data.counter] =3D NULL;
+	string_list_foreach(item, refs) {
+		struct notes_tree *t =3D xcalloc(1, sizeof(struct notes_tree));
+		init_notes(t, item->string, combine_notes_ignore, 0);
+		trees[counter++] =3D t;
+	}
+	trees[counter] =3D NULL;
 	return trees;
 }

@@ -995,10 +975,12 @@ void init_display_notes(struct display_notes_opt *opt=
)

 	git_config(notes_display_config, &load_config_refs);

-	if (opt && opt->extra_notes_refs)
-		for_each_string_list(string_list_add_refs_from_list,
-				     opt->extra_notes_refs,
-				     &display_notes_refs);
+	if (opt && opt->extra_notes_refs) {
+		struct string_list_item *item;
+		string_list_foreach(item, opt->extra_notes_refs)
+			string_list_add_refs_by_glob(&display_notes_refs,
+						     item->string);
+        }

 	display_notes_trees =3D load_notes_trees(&display_notes_refs);
 	string_list_clear(&display_notes_refs, 0);
diff --git a/resolve-undo.c b/resolve-undo.c
index 0f50ee0..a3152ff 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -28,29 +28,25 @@ void record_resolve_undo(struct index_state
*istate, struct cache_entry *ce)
 	ui->mode[stage - 1] =3D ce->ce_mode;
 }

-static int write_one(struct string_list_item *item, void *cbdata)
+void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_und=
o)
 {
-	struct strbuf *sb =3D cbdata;
-	struct resolve_undo_info *ui =3D item->util;
-	int i;
+	struct string_list_item *item;
+	string_list_foreach(item, resolve_undo) {
+		struct resolve_undo_info *ui =3D item->util;
+		int i;

-	if (!ui)
-		return 0;
-	strbuf_addstr(sb, item->string);
-	strbuf_addch(sb, 0);
-	for (i =3D 0; i < 3; i++)
-		strbuf_addf(sb, "%o%c", ui->mode[i], 0);
-	for (i =3D 0; i < 3; i++) {
-		if (!ui->mode[i])
+		if (!ui)
 			continue;
-		strbuf_add(sb, ui->sha1[i], 20);
+		strbuf_addstr(sb, item->string);
+		strbuf_addch(sb, 0);
+		for (i =3D 0; i < 3; i++)
+			strbuf_addf(sb, "%o%c", ui->mode[i], 0);
+		for (i =3D 0; i < 3; i++) {
+			if (!ui->mode[i])
+				continue;
+			strbuf_add(sb, ui->sha1[i], 20);
+		}
 	}
-	return 0;
-}
-
-void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_und=
o)
-{
-	for_each_string_list(write_one, resolve_undo, sb);
 }

 struct string_list *resolve_undo_read(const char *data, unsigned long size=
)
--=20
1.7.1.622.g408a98

--0015174c445c1b11b5048a272586
Content-Type: application/octet-stream; 
	name="0002-Convert-the-users-for-of-for_each_string_list-to-stri.diff"
Content-Disposition: attachment; 
	filename="0002-Convert-the-users-for-of-for_each_string_list-to-stri.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gb0hi1l91

RnJvbSA0NGY0ZDY1NDc2ZGY5N2YyYWViNDE0OWY3NWUzZTgwNzQzN2FmNGExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDI5IEp1biAyMDEwIDEwOjAzOjQxICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIENv
bnZlcnQgdGhlIHVzZXJzIGZvciBvZiBmb3JfZWFjaF9zdHJpbmdfbGlzdCB0byBzdHJpbmdfbGlz
dF9mb3JfZWFjaAoKVGhlIG1hY3JvIGlzIHN1aXRhYmxlIGZvciBhbGwgdGhlc2UgY2FzZXMgYW5k
IHdpbGwgcmVkdWNlIGNvZGUgb2YKbmVlZCB0byBqdXN0IGl0ZXJhdGUgb3ZlciB0aGUgaXRlbXMg
b2YgYSBzdHJpbmcgbGlzdC4KClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBn
bWFpbC5jb20+Ci0tLQogbm90ZXMuYyAgICAgICAgfCAgIDQ2ICsrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHJlc29sdmUtdW5kby5jIHwgICAzNCArKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlv
bnMoKyksIDUxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25vdGVzLmMgYi9ub3Rlcy5jCmlu
ZGV4IDZlZTA0ZTcuLjRkNWFkMzUgMTAwNjQ0Ci0tLSBhL25vdGVzLmMKKysrIGIvbm90ZXMuYwpA
QCAtODc3LDE0ICs4NzcsNiBAQCB2b2lkIHN0cmluZ19saXN0X2FkZF9yZWZzX2Zyb21fY29sb25f
c2VwKHN0cnVjdCBzdHJpbmdfbGlzdCAqbGlzdCwKIAlzdHJidWZfcmVsZWFzZSgmZ2xvYmJ1Zik7
CiB9CiAKLXN0YXRpYyBpbnQgc3RyaW5nX2xpc3RfYWRkX3JlZnNfZnJvbV9saXN0KHN0cnVjdCBz
dHJpbmdfbGlzdF9pdGVtICppdGVtLAotCQkJCQkgIHZvaWQgKmNiKQotewotCXN0cnVjdCBzdHJp
bmdfbGlzdCAqbGlzdCA9IGNiOwotCXN0cmluZ19saXN0X2FkZF9yZWZzX2J5X2dsb2IobGlzdCwg
aXRlbS0+c3RyaW5nKTsKLQlyZXR1cm4gMDsKLX0KLQogc3RhdGljIGludCBub3Rlc19kaXNwbGF5
X2NvbmZpZyhjb25zdCBjaGFyICprLCBjb25zdCBjaGFyICp2LCB2b2lkICpjYikKIHsKIAlpbnQg
KmxvYWRfcmVmcyA9IGNiOwpAQCAtOTQ3LDMwICs5MzksMTggQEAgdm9pZCBpbml0X25vdGVzKHN0
cnVjdCBub3Rlc190cmVlICp0LCBjb25zdCBjaGFyICpub3Rlc19yZWYsCiAJbG9hZF9zdWJ0cmVl
KHQsICZyb290X3RyZWUsIHQtPnJvb3QsIDApOwogfQogCi1zdHJ1Y3QgbG9hZF9ub3Rlc19jYl9k
YXRhIHsKLQlpbnQgY291bnRlcjsKLQlzdHJ1Y3Qgbm90ZXNfdHJlZSAqKnRyZWVzOwotfTsKLQot
c3RhdGljIGludCBsb2FkX29uZV9kaXNwbGF5X25vdGVfcmVmKHN0cnVjdCBzdHJpbmdfbGlzdF9p
dGVtICppdGVtLAotCQkJCSAgICAgdm9pZCAqY2JfZGF0YSkKLXsKLQlzdHJ1Y3QgbG9hZF9ub3Rl
c19jYl9kYXRhICpjID0gY2JfZGF0YTsKLQlzdHJ1Y3Qgbm90ZXNfdHJlZSAqdCA9IHhjYWxsb2Mo
MSwgc2l6ZW9mKHN0cnVjdCBub3Rlc190cmVlKSk7Ci0JaW5pdF9ub3Rlcyh0LCBpdGVtLT5zdHJp
bmcsIGNvbWJpbmVfbm90ZXNfaWdub3JlLCAwKTsKLQljLT50cmVlc1tjLT5jb3VudGVyKytdID0g
dDsKLQlyZXR1cm4gMDsKLX0KLQogc3RydWN0IG5vdGVzX3RyZWUgKipsb2FkX25vdGVzX3RyZWVz
KHN0cnVjdCBzdHJpbmdfbGlzdCAqcmVmcykKIHsKKwlzdHJ1Y3Qgc3RyaW5nX2xpc3RfaXRlbSAq
aXRlbTsKKwlpbnQgY291bnRlciA9IDA7CiAJc3RydWN0IG5vdGVzX3RyZWUgKip0cmVlczsKLQlz
dHJ1Y3QgbG9hZF9ub3Rlc19jYl9kYXRhIGNiX2RhdGE7CiAJdHJlZXMgPSB4bWFsbG9jKChyZWZz
LT5ucisxKSAqIHNpemVvZihzdHJ1Y3Qgbm90ZXNfdHJlZSAqKSk7Ci0JY2JfZGF0YS5jb3VudGVy
ID0gMDsKLQljYl9kYXRhLnRyZWVzID0gdHJlZXM7Ci0JZm9yX2VhY2hfc3RyaW5nX2xpc3QobG9h
ZF9vbmVfZGlzcGxheV9ub3RlX3JlZiwgcmVmcywgJmNiX2RhdGEpOwotCXRyZWVzW2NiX2RhdGEu
Y291bnRlcl0gPSBOVUxMOworCXN0cmluZ19saXN0X2ZvcmVhY2goaXRlbSwgcmVmcykgeworCQlz
dHJ1Y3Qgbm90ZXNfdHJlZSAqdCA9IHhjYWxsb2MoMSwgc2l6ZW9mKHN0cnVjdCBub3Rlc190cmVl
KSk7CisJCWluaXRfbm90ZXModCwgaXRlbS0+c3RyaW5nLCBjb21iaW5lX25vdGVzX2lnbm9yZSwg
MCk7CisJCXRyZWVzW2NvdW50ZXIrK10gPSB0OworCX0KKwl0cmVlc1tjb3VudGVyXSA9IE5VTEw7
CiAJcmV0dXJuIHRyZWVzOwogfQogCkBAIC05OTUsMTAgKzk3NSwxMiBAQCB2b2lkIGluaXRfZGlz
cGxheV9ub3RlcyhzdHJ1Y3QgZGlzcGxheV9ub3Rlc19vcHQgKm9wdCkKIAogCWdpdF9jb25maWco
bm90ZXNfZGlzcGxheV9jb25maWcsICZsb2FkX2NvbmZpZ19yZWZzKTsKIAotCWlmIChvcHQgJiYg
b3B0LT5leHRyYV9ub3Rlc19yZWZzKQotCQlmb3JfZWFjaF9zdHJpbmdfbGlzdChzdHJpbmdfbGlz
dF9hZGRfcmVmc19mcm9tX2xpc3QsCi0JCQkJICAgICBvcHQtPmV4dHJhX25vdGVzX3JlZnMsCi0J
CQkJICAgICAmZGlzcGxheV9ub3Rlc19yZWZzKTsKKwlpZiAob3B0ICYmIG9wdC0+ZXh0cmFfbm90
ZXNfcmVmcykgeworCQlzdHJ1Y3Qgc3RyaW5nX2xpc3RfaXRlbSAqaXRlbTsKKwkJc3RyaW5nX2xp
c3RfZm9yZWFjaChpdGVtLCBvcHQtPmV4dHJhX25vdGVzX3JlZnMpCisJCQlzdHJpbmdfbGlzdF9h
ZGRfcmVmc19ieV9nbG9iKCZkaXNwbGF5X25vdGVzX3JlZnMsCisJCQkJCQkgICAgIGl0ZW0tPnN0
cmluZyk7CisgICAgICAgIH0KIAogCWRpc3BsYXlfbm90ZXNfdHJlZXMgPSBsb2FkX25vdGVzX3Ry
ZWVzKCZkaXNwbGF5X25vdGVzX3JlZnMpOwogCXN0cmluZ19saXN0X2NsZWFyKCZkaXNwbGF5X25v
dGVzX3JlZnMsIDApOwpkaWZmIC0tZ2l0IGEvcmVzb2x2ZS11bmRvLmMgYi9yZXNvbHZlLXVuZG8u
YwppbmRleCAwZjUwZWUwLi5hMzE1MmZmIDEwMDY0NAotLS0gYS9yZXNvbHZlLXVuZG8uYworKysg
Yi9yZXNvbHZlLXVuZG8uYwpAQCAtMjgsMjkgKzI4LDI1IEBAIHZvaWQgcmVjb3JkX3Jlc29sdmVf
dW5kbyhzdHJ1Y3QgaW5kZXhfc3RhdGUgKmlzdGF0ZSwgc3RydWN0IGNhY2hlX2VudHJ5ICpjZSkK
IAl1aS0+bW9kZVtzdGFnZSAtIDFdID0gY2UtPmNlX21vZGU7CiB9CiAKLXN0YXRpYyBpbnQgd3Jp
dGVfb25lKHN0cnVjdCBzdHJpbmdfbGlzdF9pdGVtICppdGVtLCB2b2lkICpjYmRhdGEpCit2b2lk
IHJlc29sdmVfdW5kb193cml0ZShzdHJ1Y3Qgc3RyYnVmICpzYiwgc3RydWN0IHN0cmluZ19saXN0
ICpyZXNvbHZlX3VuZG8pCiB7Ci0Jc3RydWN0IHN0cmJ1ZiAqc2IgPSBjYmRhdGE7Ci0Jc3RydWN0
IHJlc29sdmVfdW5kb19pbmZvICp1aSA9IGl0ZW0tPnV0aWw7Ci0JaW50IGk7CisJc3RydWN0IHN0
cmluZ19saXN0X2l0ZW0gKml0ZW07CisJc3RyaW5nX2xpc3RfZm9yZWFjaChpdGVtLCByZXNvbHZl
X3VuZG8pIHsKKwkJc3RydWN0IHJlc29sdmVfdW5kb19pbmZvICp1aSA9IGl0ZW0tPnV0aWw7CisJ
CWludCBpOwogCi0JaWYgKCF1aSkKLQkJcmV0dXJuIDA7Ci0Jc3RyYnVmX2FkZHN0cihzYiwgaXRl
bS0+c3RyaW5nKTsKLQlzdHJidWZfYWRkY2goc2IsIDApOwotCWZvciAoaSA9IDA7IGkgPCAzOyBp
KyspCi0JCXN0cmJ1Zl9hZGRmKHNiLCAiJW8lYyIsIHVpLT5tb2RlW2ldLCAwKTsKLQlmb3IgKGkg
PSAwOyBpIDwgMzsgaSsrKSB7Ci0JCWlmICghdWktPm1vZGVbaV0pCisJCWlmICghdWkpCiAJCQlj
b250aW51ZTsKLQkJc3RyYnVmX2FkZChzYiwgdWktPnNoYTFbaV0sIDIwKTsKKwkJc3RyYnVmX2Fk
ZHN0cihzYiwgaXRlbS0+c3RyaW5nKTsKKwkJc3RyYnVmX2FkZGNoKHNiLCAwKTsKKwkJZm9yIChp
ID0gMDsgaSA8IDM7IGkrKykKKwkJCXN0cmJ1Zl9hZGRmKHNiLCAiJW8lYyIsIHVpLT5tb2RlW2ld
LCAwKTsKKwkJZm9yIChpID0gMDsgaSA8IDM7IGkrKykgeworCQkJaWYgKCF1aS0+bW9kZVtpXSkK
KwkJCQljb250aW51ZTsKKwkJCXN0cmJ1Zl9hZGQoc2IsIHVpLT5zaGExW2ldLCAyMCk7CisJCX0K
IAl9Ci0JcmV0dXJuIDA7Ci19Ci0KLXZvaWQgcmVzb2x2ZV91bmRvX3dyaXRlKHN0cnVjdCBzdHJi
dWYgKnNiLCBzdHJ1Y3Qgc3RyaW5nX2xpc3QgKnJlc29sdmVfdW5kbykKLXsKLQlmb3JfZWFjaF9z
dHJpbmdfbGlzdCh3cml0ZV9vbmUsIHJlc29sdmVfdW5kbywgc2IpOwogfQogCiBzdHJ1Y3Qgc3Ry
aW5nX2xpc3QgKnJlc29sdmVfdW5kb19yZWFkKGNvbnN0IGNoYXIgKmRhdGEsIHVuc2lnbmVkIGxv
bmcgc2l6ZSkKLS0gCjEuNy4xLjYyMi5nNDA4YTk4Cgo=
--0015174c445c1b11b5048a272586--
