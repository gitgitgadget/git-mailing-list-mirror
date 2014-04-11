From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically
 update it
Date: Fri, 11 Apr 2014 17:36:58 +0700
Message-ID: <CACsJy8DGq8Q8i8pgYivcMhnk99gYhnKvSWUsetFL=+3L8YLPew@mail.gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com> <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Yiannis Marangos <yiannis.marangos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 12:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYYq2-00017W-V3
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 12:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbaDKKhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 06:37:33 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:42169 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122AbaDKKh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 06:37:29 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so5055347qaq.24
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S/N8WFXQuZvKbWytS3gjbbo2uAgJVnRAQXtUtlPwUCU=;
        b=wnAY7iOXm6gsnsaF9iUdVTodrdlVV7uX0Snk0Rh4xMFkK0FSdsFqIaIhu2YadkjbiS
         1ouN7rP3NMnis1cHq9758ObDbbPyLAbMu2ZtkRwAqkHIvJ+C1mMj+T0n397iAsg7HcYf
         dpvNF5a+G21b99aWT2/bwaUtzL/d1vM9JD1seB7P+Qd/IqIfkusQOwf2BVnA9b3yPztH
         5WlDncwhDX0ta6k4Surn4n2PqDSvvMUgmCh46Ml1IM5zvMTuToHqfqHH/ijXq+OIeMdL
         1fbCeSBdZBcrkQbnD61l7x+UAO2TgWjCbyZnkpucgXOOLs9lXqxrmDqIyk/Jma1SSY97
         hFsQ==
X-Received: by 10.140.23.8 with SMTP id 8mr26199438qgo.0.1397212648728; Fri,
 11 Apr 2014 03:37:28 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Fri, 11 Apr 2014 03:36:58 -0700 (PDT)
In-Reply-To: <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246076>

On Fri, Apr 11, 2014 at 2:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> +static int verify_index_from(const struct index_state *istate, const char *path)
> +{
> +       int fd;
> +       ssize_t n;
> +       struct stat st;
> +       unsigned char sha1[20];
> +
> +       if (!istate->initialized)
> +               return 0;
> +
> +       fd = open(path, O_RDONLY);
> +       if (fd < 0)
> +               return 0;

Suppose another process "git rm --cached :/" is racing with us and
this imaginary git is so smart that it figures if nothing valueable is
left in the index, there's no need to write the index down at all. So
it removes $GIT_DIR/index, then $GIT_DIR/index.lock. When we come
here, we see ENOENT, but we should return 1 instead because the file
removal in this case is a form of change.

That opens a question about writing a new index. I think we could use
all-zero sha-1 as the indicator that this is a fresh new index. If
istate->sha1[] is all-zero and no index file exists, then we do not
need to verify (i.e. return 0). However if istate->sha1[] is all-zero,
but $GIT_DIR/index exists, then return 1.

I'm still not sure if elsewhere in the code base we read
$GIT_DIR/index to active_index, create a new index_state, copy entries
over (but not active_index.sha1[]), then write the _new_ index_state
down. That would hit the "however" statement above and incorrectly
return 1.

I suppose that all other errors except ENOENT could be safely ignored
(i.e. return 0 regardless of istate->sha1[]).

> +
> +       if (fstat(fd, &st))
> +               goto out;
> +
> +       if (st.st_size < sizeof(struct cache_header) + 20)
> +               goto out;
> +
> +       n = pread_in_full(fd, sha1, 20, st.st_size - 20);
> +       if (n != 20)
> +               goto out;
> +
> +       if (hashcmp(istate->sha1, sha1))
> +               goto out;
> +
> +       close(fd);
> +       return 1;
> +
> +out:
> +       close(fd);
> +       return 0;
> +}
> +
> +static int verify_index(const struct index_state *istate)
> +{
> +       return verify_index_from(istate, get_index_file());
> +}
> +
>  static int has_racy_timestamp(struct index_state *istate)
>  {
>         int entries = istate->cache_nr;
> @@ -1766,7 +1811,7 @@ static int has_racy_timestamp(struct index_state *istate)
>  void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
>  {
>         if ((istate->cache_changed || has_racy_timestamp(istate)) &&
> -           !write_index(istate, lockfile->fd))
> +           verify_index(istate) && !write_index(istate, lockfile->fd))
>                 commit_locked_index(lockfile);
>         else
>                 rollback_lock_file(lockfile);
> diff --git a/wrapper.c b/wrapper.c
> index 5b3c7fc..bc1bfb8 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -232,6 +232,26 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
>         return total;
>  }
>
> +ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
> +{
> +       char *p = buf;
> +       ssize_t total = 0;
> +
> +       while (count > 0) {
> +               ssize_t loaded = xpread(fd, p, count, offset);
> +               if (loaded < 0)
> +                       return -1;
> +               if (loaded == 0)
> +                       return total;
> +               count -= loaded;
> +               p += loaded;
> +               total += loaded;
> +               offset += loaded;
> +       }
> +
> +       return total;
> +}
> +
>  int xdup(int fd)
>  {
>         int ret = dup(fd);
> --
> 1.9.2-590-g468068b
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
