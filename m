From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 08/19] grep.c: Use index api
Date: Mon, 15 Jul 2013 11:51:39 +0200
Message-ID: <87bo64cfro.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-9-git-send-email-t.gummerer@gmail.com> <CACsJy8CMqJ5TF1V7CMTQjnAUp=zXPYxotq5uLqvaF0Sikzv+uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 11:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfRc-0006ou-7N
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab3GOJvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:51:44 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:43624 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab3GOJvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:51:43 -0400
Received: by mail-ee0-f45.google.com with SMTP id c1so7461211eek.32
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=cxSDyba6OJUkbHU+QNkeFdYIzUXzLT4zxYQXqGAhfVk=;
        b=qH/Eiy1b2aiT9aR++1wCYQ54ZWABhnSLDoZAURkXPpdzIA3o9vnP3hyq/3fBs0lRkn
         5uvgaPxwfOWL/p5YOrBCvwoyf7oIXOhUFoCN395hZq1JYsFVH7zePmMxNGmaytZlzFCo
         npaIQLKCaCJnmPE8Vz+NJc32+wDPzyRMXnBUPlNwt0l3zNTjCzuyX0oy50jNrEN/glmH
         MwwawI/osC6XBC8Fc27MK0nSWkmJCEG/gdi2sjnwii+7NGltFjCT3RuwacKuQx2350VF
         ldGhB23YxyhJv7fVgOvJnEYdqs29ohzACu+K9vga6OnfXCRRZvALiEbUD/fwv+lScgRq
         klRQ==
X-Received: by 10.14.182.132 with SMTP id o4mr57573612eem.94.1373881902014;
        Mon, 15 Jul 2013 02:51:42 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id l42sm101198652eeo.14.2013.07.15.02.51.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 02:51:41 -0700 (PDT)
In-Reply-To: <CACsJy8CMqJ5TF1V7CMTQjnAUp=zXPYxotq5uLqvaF0Sikzv+uw@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230455>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +static int grep_cache(struct cache_entry *ce, void *cb_data)
>>  {
>> -       int hit = 0;
>> -       int nr;
>> -       read_cache();
>> +       struct grep_opts *opts = cb_data;
>>
>> -       for (nr = 0; nr < active_nr; nr++) {
>> -               struct cache_entry *ce = active_cache[nr];
>> -               if (!S_ISREG(ce->ce_mode))
>> -                       continue;
>> -               if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
>> -                       continue;
>> -               /*
>> -                * If CE_VALID is on, we assume worktree file and its cache entry
>> -                * are identical, even if worktree file has been modified, so use
>> -                * cache version instead
>> -                */
>> -               if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
>> -                       if (ce_stage(ce))
>> -                               continue;
>> -                       hit |= grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
>> -               }
>> -               else
>> -                       hit |= grep_file(opt, ce->name);
>> -               if (ce_stage(ce)) {
>> -                       do {
>> -                               nr++;
>> -                       } while (nr < active_nr &&
>> -                                !strcmp(ce->name, active_cache[nr]->name));
>> -                       nr--; /* compensate for loop control */
>> -               }
>> -               if (hit && opt->status_only)
>> -                       break;
>> -       }
>> -       return hit;
>> +       if (!S_ISREG(ce->ce_mode))
>> +               return 0;
>> +       if (!match_pathspec_depth(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL))
>> +               return 0;
>
> You do a match_pathspec_depth here..
>
>> @@ -895,10 +887,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>         } else if (0 <= opt_exclude) {
>>                 die(_("--[no-]exclude-standard cannot be used for tracked contents."));
>>         } else if (!list.nr) {
>> +               struct grep_opts opts;
>> +               struct filter_opts *filter_opts = xmalloc(sizeof(*filter_opts));
>> +
>>                 if (!cached)
>>                         setup_work_tree();
>>
>> -               hit = grep_cache(&opt, &pathspec, cached);
>> +               memset(filter_opts, 0, sizeof(*filter_opts));
>> +               filter_opts->pathspec = &pathspec;
>> +               opts.opt = &opt;
>> +               opts.pathspec = &pathspec;
>> +               opts.cached = cached;
>> +               opts.hit = 0;
>> +               read_cache_filtered(filter_opts);
>> +               for_each_cache_entry(grep_cache, &opts);
>
> And here again inside for_each_cache_entry. In the worst case that
> could turn into 2 expensive fnmatch instead of one. Is this conversion
> worth it? Note that match_pathspec is just a deprecated version of
> match_pathspec_depth. They basically do the same thing.

Right, the match_pathspec_depth should in builtin/grep.c should be
removed, it's unnecessary when using for_each_index_entry.  Thanks for
spotting it.  Other than that I still think the change makes sense.
