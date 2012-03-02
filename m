From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [RFH] unpack-trees: cache_entry lifetime issue?
Date: Fri, 02 Mar 2012 18:25:54 +0100
Message-ID: <4F5102A2.70303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 18:26:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3WFE-0003VZ-SI
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 18:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976Ab2CBR0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 12:26:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:38631 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab2CBR0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 12:26:06 -0500
Received: from [192.168.2.105] (p4FFD830F.dip.t-dialin.net [79.253.131.15])
	by india601.server4you.de (Postfix) with ESMTPSA id AFBEB2F8051;
	Fri,  2 Mar 2012 18:26:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192051>

Hello,

below is the output of "git grep -hnW unpack_nondirectories",
which shows some parts of unpack-trees.c that I use as context to
ask: Should we check for o->merge in line 775, before using src[0]?

If o->merge is 0, the src[0] will be NULL right up to the call of
unpack_nondirectories() in line 772.  There it may be set (in line
582).  In that case we'll end up at line 779, where mark_ce_used()
is applied to it.

I suspect that this is unintended and that line 775 should rather
read "if (o->merge && src[0]) {".  Can someone with a better
understanding of unpack-trees confirm or refute that suspicion?

Thanks,
Ren=C3=A9


542:static int unpack_nondirectories(int n, unsigned long mask,
543-				 unsigned long dirmask,
544-				 struct cache_entry **src,
545-				 const struct name_entry *names,
546-				 const struct traverse_info *info)
547-{
548-	int i;
549-	struct unpack_trees_options *o =3D info->data;
550-	unsigned long conflicts;
551-
552-	/* Do we have *only* directories? Nothing to do */
553-	if (mask =3D=3D dirmask && !src[0])
554-		return 0;
555-
556-	conflicts =3D info->conflicts;
557-	if (o->merge)
558-		conflicts >>=3D 1;
559-	conflicts |=3D dirmask;
560-
561-	/*
562-	 * Ok, we've filled in up to any potential index entry in src[0],
563-	 * now do the rest.
564-	 */
565-	for (i =3D 0; i < n; i++) {
566-		int stage;
567-		unsigned int bit =3D 1ul << i;
568-		if (conflicts & bit) {
569-			src[i + o->merge] =3D o->df_conflict_entry;
570-			continue;
571-		}
572-		if (!(mask & bit))
573-			continue;
574-		if (!o->merge)
575-			stage =3D 0;
576-		else if (i + 1 < o->head_idx)
577-			stage =3D 1;
578-		else if (i + 1 > o->head_idx)
579-			stage =3D 3;
580-		else
581-			stage =3D 2;

582-		src[i + o->merge] =3D create_ce_entry(info, names + i, stage);

583-	}
584-
585-	if (o->merge)
586-		return call_unpack_fn(src, o);
587-
588-	for (i =3D 0; i < n; i++)
589-		if (src[i] && src[i] !=3D o->df_conflict_entry)
590-			add_entry(o, src[i], 0, 0);
591-	return 0;
592-}
593-
--
721=3Dstatic int unpack_callback(int n, unsigned long mask, unsigned lo=
ng dirmask, struct name_entry *names, struct traverse_info *info)
722-{
723-	struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
724-	struct unpack_trees_options *o =3D info->data;
725-	const struct name_entry *p =3D names;
726-
727-	/* Find first entry with a real name (we could use "mask" too) */
728-	while (!p->mode)
729-		p++;
730-
731-	if (o->debug_unpack)
732-		debug_unpack_callback(n, mask, dirmask, names, info);
733-
734-	/* Are we supposed to look at the index too? */
735-	if (o->merge) {
736-		while (1) {
737-			int cmp;
738-			struct cache_entry *ce;
739-
740-			if (o->diff_index_cached)
741-				ce =3D next_cache_entry(o);
742-			else
743-				ce =3D find_cache_entry(info, p);
744-
745-			if (!ce)
746-				break;
747-			cmp =3D compare_entry(ce, info, p);
748-			if (cmp < 0) {
749-				if (unpack_index_entry(ce, o) < 0)
750-					return unpack_failed(o, NULL);
751-				continue;
752-			}
753-			if (!cmp) {
754-				if (ce_stage(ce)) {
755-					/*
756-					 * If we skip unmerged index
757-					 * entries, we'll skip this
758-					 * entry *and* the tree
759-					 * entries associated with it!
760-					 */
761-					if (o->skip_unmerged) {
762-						add_same_unmerged(ce, o);
763-						return mask;
764-					}
765-				}
766-				src[0] =3D ce;
767-			}
768-			break;
769-		}
770-	}
771-

772:	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
773-		return -1;
774-
775-	if (src[0]) {
776-		if (ce_stage(src[0]))
777-			mark_ce_used_same_name(src[0], o);
778-		else
779-			mark_ce_used(src[0], o);
780-	}

781-
782-	/* Now handle any directories.. */
783-	if (dirmask) {
784-		unsigned long conflicts =3D mask & ~dirmask;
785-		if (o->merge) {
786-			conflicts <<=3D 1;
787-			if (src[0])
788-				conflicts |=3D 1;
789-		}
790-
791-		/* special case: "diff-index --cached" looking at a tree */
792-		if (o->diff_index_cached &&
793-		    n =3D=3D 1 && dirmask =3D=3D 1 && S_ISDIR(names->mode)) {
794-			int matches;
795-			matches =3D cache_tree_matches_traversal(o->src_index->cache_tre=
e,
796-							       names, info);
797-			/*
798-			 * Everything under the name matches; skip the
799-			 * entire hierarchy.  diff_index_cached codepath
800-			 * special cases D/F conflicts in such a way that
801-			 * it does not do any look-ahead, so this is safe.
802-			 */
803-			if (matches) {
804-				o->cache_bottom +=3D matches;
805-				return mask;
806-			}
807-		}
808-
809-		if (traverse_trees_recursive(n, dirmask, conflicts,
810-					     names, info) < 0)
811-			return -1;
812-		return mask;
813-	}
814-
815-	return mask;
816-}
817-

PS: These functions are a tad too long, aren't they? ;-)
