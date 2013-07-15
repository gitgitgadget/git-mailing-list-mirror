From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] do_one_ref(): save and restore value of current_ref
Date: Mon, 15 Jul 2013 17:24:17 +0200
Message-ID: <1373901857-28431-1-git-send-email-mhagger@alum.mit.edu>
References: <CAPWNY8Ua=3t4jeDvkj3Aw2Ouvv+0r1kWrET5GNq9uS8PasGudQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:25:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyke5-0007Mw-8t
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab3GOPYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 11:24:50 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63069 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932914Ab3GOPYg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 11:24:36 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-fc-51e41433f552
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B6.A5.17335.33414E15; Mon, 15 Jul 2013 11:24:36 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6FFOUlt018101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Jul 2013 11:24:34 -0400
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <CAPWNY8Ua=3t4jeDvkj3Aw2Ouvv+0r1kWrET5GNq9uS8PasGudQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqGsi8iTQ4PZuFouuK91MFg29V5gt
	XrYfYLa4vWI+swOLx9/3H5g8ds66y+5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGavv7WMt
	2CVY0bP7AlsD4y+eLkZODgkBE4mGrtXsELaYxIV769m6GLk4hAQuM0pM+raLCcK5zSTx/NY2
	sCo2AV2JRT3NTCC2iICaxMS2QywgNrNAN6NES0sWiC0s4CKxr/E7K4jNIqAq8ePyS7B6XqD4
	8ouLWSC2KUgs+7KWuYuRg4NTIFDixxFukLCQQIDEm7lXoMoFJU7OfMICUsIsoC6xfp4QxCZ5
	ieats5knMArMQlI1C6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNK
	NzFCQplvB2P7eplDjAIcjEo8vBI8TwKFWBPLiitzDzFKcjApifImCQOF+JLyUyozEosz4otK
	c1KLDzFKcDArifDageR4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	jiCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAojS8GxilIigdory3Y3uKCxFyg
	KETrKUZdjslnt7xnFGLJy89LlRLnDQYpEgApyijNg1sBS1yvGMWBPhaGqOIBJj24Sa+AljAB
	LWme/RhkSUkiQkqqgTFiosx5TqVfOa/bD+YtCEk8JcS+2Lgl9FxnKYN0aOLuDfnZ8zM3qD54
	XeSufbj36/mb+nVRzD136mu1yk+0v/hR4Ff0l8PX4Fh8ZKLR9T3PzXc5y+/9FaBs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230478>

If do_one_ref() is called recursively, then the inner call should not
permanently overwrite the value stored in current_ref by the outer
call.  Aside from the tiny optimization loss, peel_ref() expects the
value of current_ref not to change across a call to peel_entry().  But
in the presence of replace references that assumption could be
violated by a recursive call to do_one_ref:

do_for_each_entry()
  do_one_ref()
    builtin/describe.c:get_name()
      peel_ref()
        peel_entry()
          peel_object ()
            deref_tag_noverify()
              parse_object()
                lookup_replace_object()
                  do_lookup_replace_object()
                    prepare_replace_object()
                      do_for_each_ref()
                        do_for_each_entry()
                          do_for_each_entry_in_dir()
                            do_one_ref()

The inner call to do_one_ref() was unconditionally setting current_ref
to NULL when it was done, causing peel_ref() to perform an invalid
memory access.

So change do_one_ref() to save the old value of current_ref before
overwriting it, and restore the old value afterward rather than
setting it to NULL.

Reported by: Mantas Mikul=C4=97nas <grawity@gmail.com>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 4302206..222baf2 100644
--- a/refs.c
+++ b/refs.c
@@ -634,7 +634,9 @@ struct ref_entry_cb {
 static int do_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct ref_entry_cb *data =3D cb_data;
+	struct ref_entry *old_current_ref;
 	int retval;
+
 	if (prefixcmp(entry->name, data->base))
 		return 0;
=20
@@ -642,10 +644,12 @@ static int do_one_ref(struct ref_entry *entry, vo=
id *cb_data)
 	      !ref_resolves_to_object(entry))
 		return 0;
=20
+	/* Store the old value, in case this is a recursive call: */
+	old_current_ref =3D current_ref;
 	current_ref =3D entry;
 	retval =3D data->fn(entry->name + data->trim, entry->u.value.sha1,
 			  entry->flag, data->cb_data);
-	current_ref =3D NULL;
+	current_ref =3D old_current_ref;
 	return retval;
 }
=20
--=20
1.8.3.2
