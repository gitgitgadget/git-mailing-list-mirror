From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: parsecvs and unnamed branches
Date: Sat, 17 Jun 2006 00:15:57 -0400
Message-ID: <9e4733910606162115g2165212bgf32a2e328cce751a@mail.gmail.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
	 <1150513943.29738.15.camel@dv>
	 <9e4733910606162031o69df27fdje50c88949ed990b5@mail.gmail.com>
	 <1150517336.9144.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Keith Packard" <keithp@keithp.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 06:16:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrSEH-0004bC-QS
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 06:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWFQEP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 00:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWFQEP6
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 00:15:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:2107 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751608AbWFQEP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 00:15:58 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1289059nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 21:15:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LcQvyJe2By+qHOBr4zl/PGQSrQ23Js7VStrVhWdkmBrwhjW7D1mK4IDQmY0Ap8Sxb0rdi9RO31OpVtBsfZjywqnjcXEi2KvCYF8TK+r2/aLjJ98Ke86Hu4mshV51wpewfxT1VpOOj2ybm8rei7dPVe+4RVrnEedpqbhqK2xEVOg=
Received: by 10.37.14.27 with SMTP id r27mr1287431nzi;
        Fri, 16 Jun 2006 21:15:57 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 21:15:57 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1150517336.9144.8.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21998>

On 6/17/06, Pavel Roskin <proski@gnu.org> wrote:
> On Fri, 2006-06-16 at 23:31 -0400, Jon Smirl wrote:
>
> > Parsecvs was compiled '-O2 -g' why didn't it decode the addresses to symbols?
>
> Sorry, I was too quick to put blame on you.  Maybe glibc can only list
> its own symbols.
>
> I could reproduce the problem trivially with a single file, and here's
> what Valgrind says:
>
> ==11154== Invalid free() / delete / delete[]
> ==11154==    at 0x4905423: free (vg_replace_malloc.c:233)
> ==11154==    by 0x40C136: git_pack_directory (git.c:620)
> ==11154==    by 0x40C1B4: git_rev_list_pack (git.c:639)
> ==11154==    by 0x4067DA: main (parsecvs.c:785)
>
>
> git_pack_directory() tries to free() the result of
> git_system_to_string(), which is in turn a result of atom().  My
> understanding is that atoms should not be freed.  They are not freed in
> other cases.
>
> Patch:
>
> diff --git a/README b/README
> diff --git a/git.c b/git.c
> index 33b29c7..7312568 100644
> --- a/git.c
> +++ b/git.c
> @@ -617,7 +617,6 @@ git_pack_directory (void)
>         }
>         free (objects_dir);
>         pack_dir = git_format_command ("%s/objects/pack", git_dir);
> -        free (git_dir);
>         if (!pack_dir)
>             return NULL;
>         if (access (pack_dir, F_OK) == -1 &&

I had already caught that one, the fix was a few mails back.
git_dir is an atom and shouldn't be freed with free.

After five hours I hit this:
fprintf (stderr, "Error: branch cycle\n");

static rev_ref *
rev_ref_tsort (rev_ref *refs, rev_list *head)
{
    rev_ref *done = NULL;
    rev_ref **done_tail = &done;
    rev_ref *r, **prev;

//    fprintf (stderr, "Tsort refs:\n");
    while (refs) {
        for (prev = &refs; (r = *prev); prev = &(*prev)->next) {
            if (rev_ref_is_ready (r->name, head, done)) {
                break;
            }
        }
        if (!r) {
            fprintf (stderr, "Error: branch cycle\n");
>> hit this test
            return NULL;
        }
        *prev = r->next;
        *done_tail = r;
//      fprintf (stderr, "\t%s\n", r->name);
        r->next = NULL;
        done_tail = &r->next;
    }
    return done;
}

which returned null up to here

    if (rev_mode == ExecuteGit && pack_objcount && autopack)
        git_rev_list_pack (pack_start, strip);
    load_status_next ();
    rl = rev_list_merge (head);
>> null to here
    if (rl) {
        switch (rev_mode) {
        case ExecuteGraph:
            dump_rev_graph (rl, NULL);
            break;
        case ExecuteSplits:
            dump_splits (rl);
            break;
        case ExecuteGit:
            git_rev_list_commit (rl, strip);
            break;
        }
    }
    if (rl)
        rev_list_free (rl, 0);
    while (head) {
        rl = head;
        head = head->next;
        rev_list_free (rl, 1);
>> tries to free the list, but the list is a loop.
>> after it wraps it will mangle memory

    }
    discard_atoms ();
    rev_free_dirs ();
    rev_commit_cleanup ();
    git_free_author_map ();
    return err;

>>But the real problem is why does it think the branches are in a loop?

-- 
Jon Smirl
jonsmirl@gmail.com
