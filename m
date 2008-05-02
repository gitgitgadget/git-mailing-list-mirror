From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Fix diff regression for submodules not checked out
Date: Fri, 02 May 2008 15:23:01 -0700
Message-ID: <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:24:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js3ff-0000Ng-Ou
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 00:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbYEBWXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 18:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbYEBWXP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 18:23:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763301AbYEBWXN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 18:23:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77C1424EE;
	Fri,  2 May 2008 18:23:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8E12724E8; Fri,  2 May 2008 18:23:08 -0400 (EDT)
In-Reply-To: <1209735336-4690-4-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Fri, 2 May 2008 21:35:35 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59FB32AE-1896-11DD-A788-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81039>

Ping Yin <pkufranky@gmail.com> writes:

> This regression is introduced by f58dbf23c3, which calls
> check_work_tree_entity in run_diff_files.  While check_work_tree_entity
> treats submodule not checked out as non stagable which causes that
> diff-files shows these submodules as deleted.

>  int run_diff_files(struct rev_info *revs, unsigned int option)
> @@ -403,7 +407,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			       sizeof(struct combine_diff_parent)*5);
>  
>  			changed = check_work_tree_entity(ce, &st, symcache);
> -			if (!changed)
> +			if (changed != ENT_INEXISTENT)
>  				dpath->mode = ce_mode_from_stat(ce, st.st_mode);

>  			else {
>  				if (changed < 0) {
> @@ -467,7 +471,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			continue;
>  
>  		changed = check_work_tree_entity(ce, &st, symcache);
> -		if (changed) {
> +		if (changed == ENT_INEXISTENT) {
>  			if (changed < 0) {
>  				perror(ce->name);
>  				continue;
> @@ -527,7 +531,7 @@ static int get_stat_data(struct cache_entry *ce,
>  		changed = check_work_tree_entity(ce, &st, cbdata->symcache);
>  		if (changed < 0)
>  			return -1;
> -		else if (changed) {
> +		else if (changed == ENT_INEXISTENT) {
>  			if (match_missing) {
>  				*sha1p = sha1;
>  				*modep = mode;

Earier I said we may have to teach the Porcelain layer (status, diff) to
equate a submodule that is not checked out and a submodule that is not
modified while keeping low-level plumbing (diff-files and diff-index)
still aware that the submodule is missing from the work tree, but that was
because I incorrectly thought there are only two cases (either the
submodule is fully checked out or the submodule directory itself does not
even exist) and treating the latter the same as an unmodified case would
mean there won't be an easy way to remove the submodule from the
superproject for Porcelains that are written in terms of diff-files and
diff-index.

But that was a faulty thinking on my part (heh, why didn't anybody correct
me?).  Actually, there are three cases:

 - submodule directory exists and it is a full fledged repository.  It may
   or may not be modified, but we can tell by looking at its .git/HEAD.

 - submodule directory exists but there is nothing there (no "init" nor
   "update" was done, just an empty directory checked out).  This is how a
   superproject with a submodule is checked out by default.

 - submodule directory itself does not even exist.

The second case is "not checked out -- treat me as unmodified", and the
third case is "the user does not want the submodule there", and the latter
is still reported as "removed".  That is exactly what your patch does.

I like it.

By the way, "inexistent" is a word, but somehow it sounds quite awkward.
Perhaps one of NONEXISTENT (more common), REMOVED (run_diff_files() takes
a SILENT_ON_REMOVED option) or or MISSING (update-index --refresh takes an
IGNORE_MISSING option) is better?  I dunno.
