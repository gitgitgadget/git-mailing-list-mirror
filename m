From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 3/4] Fix diff regression for submodules not checked out
Date: Sat, 3 May 2008 07:55:40 +0800
Message-ID: <46dff0320805021655w6235ad75k6d48c8d2ae540026@mail.gmail.com>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
	 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
	 <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 01:56:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js57B-0008L5-BT
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 01:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763736AbYEBXzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 19:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764864AbYEBXzo
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 19:55:44 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:4174 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763684AbYEBXzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 19:55:43 -0400
Received: by an-out-0708.google.com with SMTP id d40so361715and.103
        for <git@vger.kernel.org>; Fri, 02 May 2008 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zYrs7Uapvwm1Ii8UKFpJtipKVtAJ7ansnf0GtUYu0Dk=;
        b=Cm0YLkZFudQT6ZiCRXU2MnkC0cOrm4rk/QjWhcteeFmbM0JrGwoL+8MOb/CNT8/8xDsEcyzW6KV0IvHpEZw0xBsvVYUXa++vAWFq9o9XxTOlx6RisXqUs1kA7Eq8Q1DJM5r06E+GZtVKq14x5V55kqh7op/GuQoUj0VNzxbd7rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hJb7A4QZNEvO7go+xdMVU/eapJP0euWEogGG6Dx4Y7hO02U8cYMTaW+no0pQXXwvT6v1N1o/HYTPZNZ6RMfxGbbMOQ9xX5ezav6xl38+R+eEH7z/DEluU1PQowT2fpiAQXeexWgQa3/K0uCEONOMAGz2evcWlu+qKtCUwpdcvzo=
Received: by 10.100.42.17 with SMTP id p17mr5582483anp.20.1209772540770;
        Fri, 02 May 2008 16:55:40 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 2 May 2008 16:55:40 -0700 (PDT)
In-Reply-To: <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81049>

On Sat, May 3, 2008 at 6:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > This regression is introduced by f58dbf23c3, which calls
>  > check_work_tree_entity in run_diff_files.  While check_work_tree_entity
>  > treats submodule not checked out as non stagable which causes that
>  > diff-files shows these submodules as deleted.
>
>
>
> >  int run_diff_files(struct rev_info *revs, unsigned int option)
>  > @@ -403,7 +407,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  >                              sizeof(struct combine_diff_parent)*5);
>  >
>  >                       changed = check_work_tree_entity(ce, &st, symcache);
>  > -                     if (!changed)
>  > +                     if (changed != ENT_INEXISTENT)
>  >                               dpath->mode = ce_mode_from_stat(ce, st.st_mode);
>
>  >                       else {
>  >                               if (changed < 0) {
>  > @@ -467,7 +471,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  >                       continue;
>  >
>  >               changed = check_work_tree_entity(ce, &st, symcache);
>  > -             if (changed) {
>  > +             if (changed == ENT_INEXISTENT) {
>  >                       if (changed < 0) {
>  >                               perror(ce->name);
>  >                               continue;
>  > @@ -527,7 +531,7 @@ static int get_stat_data(struct cache_entry *ce,
>  >               changed = check_work_tree_entity(ce, &st, cbdata->symcache);
>  >               if (changed < 0)
>  >                       return -1;
>  > -             else if (changed) {
>  > +             else if (changed == ENT_INEXISTENT) {
>  >                       if (match_missing) {
>  >                               *sha1p = sha1;
>  >                               *modep = mode;
>
>  Earier I said we may have to teach the Porcelain layer (status, diff) to
>  equate a submodule that is not checked out and a submodule that is not
>  modified while keeping low-level plumbing (diff-files and diff-index)
>  still aware that the submodule is missing from the work tree, but that was
>  because I incorrectly thought there are only two cases (either the
>  submodule is fully checked out or the submodule directory itself does not
>  even exist) and treating the latter the same as an unmodified case would
>  mean there won't be an easy way to remove the submodule from the
>  superproject for Porcelains that are written in terms of diff-files and
>  diff-index.
>
>  But that was a faulty thinking on my part (heh, why didn't anybody correct
>  me?).  Actually, there are three cases:

Actually, i pointed out in early discussion that we use empty
directory (or directory without .git subdirectory) to represent the
3rd case. However, i don't like the trick. And i don't think you are
thinking faultily because I prefer your idea: we treat nonexistent
directory and directory without .git as the same for 'git diff'. "git
diff" will show "no modified" for both case.

One point i don't agree with you is that i think diff-files should
also show "no modified" for both case. By doing this, we can avoid the
empty directory for nonchecked out submodules. For a project with
hundreds of submodules, it's really really annoying to see so many
unused empty directories.

So how we diffrentiate removed and unchecked out? For submodule, we
don't differentiate it. If you want to remove a submodule, use "git
rm" or "git update-index --removed" instead of "rm && git commit -a".

>
>   - submodule directory exists and it is a full fledged repository.  It may
>    or may not be modified, but we can tell by looking at its .git/HEAD.
>
>   - submodule directory exists but there is nothing there (no "init" nor
>    "update" was done, just an empty directory checked out).  This is how a
>    superproject with a submodule is checked out by default.
>
>   - submodule directory itself does not even exist.
>
>  The second case is "not checked out -- treat me as unmodified", and the
>  third case is "the user does not want the submodule there", and the latter
>  is still reported as "removed".  That is exactly what your patch does.

Great, you make the 3 cases more clear.



-- 
Ping Yin
