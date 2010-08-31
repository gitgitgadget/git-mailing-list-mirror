From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 18:08:11 +0200
Message-ID: <201008311808.11203.johan@herland.net>
References: <4C7CD65F.10509@atlas-elektronik.com> <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, stefan.naewe@atlas-elektronik.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:08:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTNn-0007iW-A8
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab0HaQIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 12:08:17 -0400
Received: from smtp.opera.com ([213.236.208.81]:44508 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab0HaQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 12:08:17 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o7VG8BLf022680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Aug 2010 16:08:11 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154930>

On Tuesday 31 August 2010, Michael J Gruber wrote:
> Currently, "git notes" behaves like "git commit --allow-empty" when
> committing notes trees. In particular, removing nonexisting notes
> leads to empty commits "commits with no diff".
>
> Change this to avoid unnecessary notes commits.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

I just posted a patch with the same objective, but with a different 
approach. Instead of parsing the previous commit and comparing tree 
object SHA1s, I add a few lines of notes code to let remove_note() 
report whether it removed a note or not (thus determining whether a 
commit is necessary or not).

In general, the notes_tree.dirty flag should be sufficient to determine 
whether a commit is needed or not (remove_note()'s unconditional 
setting of this flag is also fixed in my patch).


...Johan

> ---
> I can't believe there's no easier way to lookup the sha1 of a tree of
> a commit but I didn't find any, and I did not want to employ the diff
> machinery for diffing the trees when their sha1 is (should be) known.
>
>  builtin/notes.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index fbc347c..48da228 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -303,11 +303,15 @@ int commit_notes(struct notes_tree *t, const
> char *msg) hashclr(prev_commit);
>  		parent = NULL;
>  	}
> -	if (commit_tree(buf.buf + 7, tree_sha1, parent, new_commit, NULL))
> -		die("Failed to commit notes tree to database");
> -
> -	/* Update notes ref with new commit */
> -	update_ref(buf.buf, t->ref, new_commit, prev_commit, 0,
> DIE_ON_ERR); +	if (!parent || parse_commit(parent->item) ||
> parse_tree(parent->item->tree) ||
> +		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {
> +		/* avoid recommitting the same tree */
> +		if (commit_tree(buf.buf + 7, tree_sha1, parent, new_commit, NULL))
> +			die("Failed to commit notes tree to database");
> +
> +		/* Update notes ref with new commit */
> +		update_ref(buf.buf, t->ref, new_commit, prev_commit, 0,
> DIE_ON_ERR); +	}
>
>  	strbuf_release(&buf);
>  	return 0;



-- 
Johan Herland, <johan@herland.net>
www.herland.net
