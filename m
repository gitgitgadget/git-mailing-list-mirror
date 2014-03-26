From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH 12/19] tree-diff: remove special-case diff-emitting code
 for empty-tree cases
Date: Wed, 26 Mar 2014 22:32:30 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140326183230.GA16002@mini.zxlink>
References: <xmqqzjkej5ju.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSsld-0002le-O1
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbaCZSld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 14:41:33 -0400
Received: from forward2o.mail.yandex.net ([37.140.190.31]:39317 "EHLO
	forward2o.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaCZSlb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 14:41:31 -0400
X-Greylist: delayed 733 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Mar 2014 14:41:30 EDT
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [37.140.190.29])
	by forward2o.mail.yandex.net (Yandex) with ESMTP id B62BA4860E94;
	Wed, 26 Mar 2014 22:29:05 +0400 (MSK)
Received: from smtp4o.mail.yandex.net (localhost [127.0.0.1])
	by smtp4o.mail.yandex.net (Yandex) with ESMTP id 53C2B23214D6;
	Wed, 26 Mar 2014 22:29:05 +0400 (MSK)
Received: from unknown (unknown [78.25.121.37])
	by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id O6ZYgTWVkh-T3w0T8Gg;
	Wed, 26 Mar 2014 22:29:03 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 2e8ffd58-5dfd-4de4-ad9a-0713858e75dd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395858544; bh=hBOMoTeyw1hXEJwXu9NiGTffU57IRjQtgvSnktk2uFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization:User-Agent;
	b=P2MlLnqQP/udS8hAP0wxWNHDOAxTyZasz7cr3009nUghnTDCdmMbbI9u9niTm2xA6
	 KcBX/YeZixd1VPVn7zUc97CjgQVDTMw6BvKYDEiz6khkgLjprzF19yYorqAxJYgtX7
	 cNKBby1DL4Qrdirqu8i9uYrQRSo8zCkpHSTf3o90=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WSsco-0005MY-O0; Wed, 26 Mar 2014 22:32:30 +0400
Content-Disposition: inline
In-Reply-To: <xmqqzjkej5ju.fsf@gitster.dls.corp.google.com>
 <xmqq8urymaua.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245203>

On Tue, Mar 25, 2014 at 10:45:01AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
>=20
> >> >  static int tree_entry_pathcmp(struct tree_desc *t1, struct tree=
_desc *t2)
> >> >  {
> >> >  	struct name_entry *e1, *e2;
> >> >  	int cmp;
> >> > =20
> >> > +	if (!t1->size)
> >> > +		return t2->size ? +1 /* +=E2=88=9E > c */  : 0 /* +=E2=88=9E =
=3D +=E2=88=9E */;
> >> > +	else if (!t2->size)
> >> > +		return -1;	/* c < +=E2=88=9E */
> >>=20
> >> Where do these "c" come from?  I somehow feel that these comments
> >> are making it harder to understand what is going on.
> >
> > "c" means some finite "c"onstant here. When I was studying at schoo=
l and
> > at the university, it was common to denote constants via this lette=
r -
> > i.e. in algebra and operators they often show scalar multiplication=
 as
> >
> >     c=C2=B7A     (or =CE=B1=C2=B7A)
> >
> > etc. I understand it could maybe be confusing (but it came to me as
> > surprise), so would the following be maybe better:
> >
> >         if (!t1->size)
> >         	return t2->size ? +1 /* +=E2=88=9E > const */  : 0 /* +=E2=
=88=9E =3D +=E2=88=9E */;
> >         else if (!t2->size)
> >         	return -1;	/* const < +=E2=88=9E */
> >
> > ?
>=20
> Not better at all, I am afraid.  A "const" in the code usually means
> "something that does not change, as opposed to a variable", but what
> you are saying here is "t1 does not have an element but t2 still
> does. Pretend as if t1 has a virtual/fake element that is larger
> than any real element t2 may happen to have at the head of its
> queue", and you are labeling that "real element at the head of t2"
> as "const", but as the walker advances, the head element in t1 and
> t2 will change---they are not "const" in that sense, and the reader
> is left scratching his head seeing "const" there, wondering what the
> author of the comment meant.

I agree.


> "real" or "concrete" might be better a phrasing, but I do not think
> having "/* +inf > concrete */" there helps the reader understand
> what is going on in the first place.  Perhaps:
>=20
>         /*
>          * When one side is empty, pretend that it has an element
>          * that sorts later than what the other non-empty side has,
>          * so that the caller advances the non-empty side without
>          * touching the empty side.
>          */
>         if (!t1->size)
>                 return !t2->size ? 0 : 1;
>         else if (!t2->size)
>                 return -1;
>=20
> or something?

Yes, that describe the reasoning without stranger symbols. How about
taking it further with

          * NOTE empty (=3Dinvalid) descriptor(s) take part in comparis=
on as +infty,
          *      so that they sort *after* valid tree entries.
          *
          *      Due to this convention, if trees are scanned in sorted=
 order, all
          *      non-empty descriptors will be processed first.
          */
         static int tree_entry_pathcmp(struct tree_desc *t1, struct tre=
e_desc *t2)
         {
                struct name_entry *e1, *e2;
                int cmp;
        =20
                /* empty descriptors sort after valid tree entries */
                if (!t1->size)
                        return t2->size ? +1 : 0;
                else if (!t2->size)
                        return -1;

?

On Tue, Mar 25, 2014 at 03:07:33PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
>=20
> > On Mon, Mar 24, 2014 at 02:18:10PM -0700, Junio C Hamano wrote:
> >> Kirill Smelkov <kirr@mns.spb.ru> writes:
> >>=20
> >> > via teaching tree_entry_pathcmp() how to compare empty tree desc=
riptors:
> >>=20
> >> Drop this line, as you explain the "pretend empty compares bigger
> >> than anything else" idea later anyway?  This early part of the
> >> proposed log message made me hiccup while reading it.
> >
> > Hmm, I was trying to show the big picture first and only then detai=
ls...
>=20
> The subject should be sufficient for the big picture.  "OK, we are
> removing the special casing" is what we expect the reader to get.
> Then, this
>=20
> >> > While walking trees, we iterate their entries from lowest to hig=
hest in
> >> > sort order, so empty tree means all entries were already went ov=
er.
>=20
> sets the background.  "OK, the code walks two trees, both have
> sorted elements, in parallel." is what we want the reader to
> understand.  Then the next part gives the idea of pretending that
> the empty-side always compare later than the non-empty side while
> doing that parallel walking (similar to "merge").
>=20
> So, yes, I think it is a good presentation order to give big picture
> punch-line first on the subject, some background and then the
> solution.

Ok, let it be this way and let's drop it.

Here is updated patch:
(please keep author email)

---- 8< ----
=46rom: Kirill Smelkov <kirr@mns.spb.ru>
Date: Mon, 24 Feb 2014 20:21:44 +0400
Subject: [PATCH v2] tree-diff: remove special-case diff-emitting code f=
or empty-tree cases

While walking trees, we iterate their entries from lowest to highest in
sort order, so empty tree means all entries were already went over.

If we artificially assign +infinity value to such tree "entry", it will
go after all usual entries, and through the usual driver loop we will b=
e
taking the same actions, which were hand-coded for special cases, i.e.

    t1 empty, t2 non-empty
        pathcmp(+=E2=88=9E, t2) -> +1
        show_path(/*t1=3D*/NULL, t2);     /* =3D t1 > t2 case in main l=
oop */

    t1 non-empty, t2-empty
        pathcmp(t1, +=E2=88=9E) -> -1
        show_path(t1, /*t2=3D*/NULL);     /* =3D t1 < t2 case in main l=
oop */

In other words when we have t1 and t2, we return a sign that tells the
caller to indicate the "earlier" one to be emitted, and by returning th=
e
sign that causes the non-empty side to be emitted, we will automaticall=
y
cause the entries from the remaining side to be emitted, without
attempting to touch the empty side at all.  We can teach
tree_entry_pathcmp() to pretend that an empty tree has an element that
sorts after anything else to achieve this.

Right now we never go to when compared tree descriptors are both
infinity, as this condition is checked in the loop beginning as
finishing criteria, but will do so in the future, when there will be
several parents iterated simultaneously, and some pair of them would ru=
n
to the end.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

Changes since v1:

 - reworked commit log and comments as per Junio suggestions.


 tree-diff.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index f8b2607..6177658 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -12,12 +12,24 @@
  *
  * NOTE files and directories *always* compare differently, even when =
having
  *      the same name - thanks to base_name_compare().
+ *
+ * NOTE empty (=3Dinvalid) descriptor(s) take part in comparison as +i=
nfty,
+ *      so that they sort *after* valid tree entries.
+ *
+ *      Due to this convention, if trees are scanned in sorted order, =
all
+ *      non-empty descriptors will be processed first.
  */
 static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *=
t2)
 {
 	struct name_entry *e1, *e2;
 	int cmp;
=20
+	/* empty descriptors sort after valid tree entries */
+	if (!t1->size)
+		return t2->size ? +1 : 0;
+	else if (!t2->size)
+		return -1;
+
 	e1 =3D &t1->entry;
 	e2 =3D &t2->entry;
 	cmp =3D base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
@@ -150,18 +162,8 @@ int diff_tree(struct tree_desc *t1, struct tree_de=
sc *t2,
 			skip_uninteresting(t1, &base, opt);
 			skip_uninteresting(t2, &base, opt);
 		}
-		if (!t1->size) {
-			if (!t2->size)
-				break;
-			show_path(&base, opt, /*t1=3D*/NULL, t2);
-			update_tree_entry(t2);
-			continue;
-		}
-		if (!t2->size) {
-			show_path(&base, opt, t1, /*t2=3D*/NULL);
-			update_tree_entry(t1);
-			continue;
-		}
+		if (!t1->size && !t2->size)
+			break;
=20
 		cmp =3D tree_entry_pathcmp(t1, t2);
=20
--=20
1.9.rc0.143.g6fd479e
