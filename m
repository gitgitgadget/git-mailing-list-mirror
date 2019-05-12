Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEBAE1F461
	for <e@80x24.org>; Sun, 12 May 2019 00:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfELAjB (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 20:39:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49370 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfELAjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 20:39:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AB5001F461;
        Sun, 12 May 2019 00:38:59 +0000 (UTC)
Date:   Sun, 12 May 2019 00:38:59 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
Message-ID: <20190512003859.GA22361@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9ygwoj0.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Sat, May 11 2019, Eric Wong wrote:
> > +static int files_differ(FILE *fp, const char *path)
> > +{
> > +	struct stat st;
> > +	git_hash_ctx c;
> > +	struct object_id oid_old, oid_new;
> > +	struct strbuf tmp = STRBUF_INIT;
> > +	long new_len = ftell(fp);
> > +
> > +	if (new_len < 0 || stat(path, &st) < 0)
> > +		return 1;
> > +	if (!S_ISREG(st.st_mode))
> > +		return 1;
> > +	if ((off_t)new_len != st.st_size)
> > +		return 1;
> > +
> > +	rewind(fp);
> > +	if (strbuf_fread(&tmp, (size_t)new_len, fp) != (size_t)new_len)
> > +		return 1;
> > +	the_hash_algo->init_fn(&c);
> > +	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
> > +	the_hash_algo->final_fn(oid_new.hash, &c);
> > +	strbuf_release(&tmp);
> > +
> > +	if (strbuf_read_file(&tmp, path, (size_t)st.st_size) < 0)
> > +		return 1;
> > +	the_hash_algo->init_fn(&c);
> > +	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
> > +	the_hash_algo->final_fn(oid_old.hash, &c);
> > +	strbuf_release(&tmp);
> > +
> > +	return hashcmp(oid_old.hash, oid_new.hash);
> > +}
> 
> This way of doing it just seems so weirdly convoluted. Read them one at
> a time, compute the SHA-1, just to see if they're different. Why not
> something closer to a plain memcmp():
> 
> 	static int files_differ(FILE *fp, const char *path)
> 	{
> 		struct strbuf old = STRBUF_INIT, new = STRBUF_INIT;
> 		long new_len = ftell(fp);
> 		int diff = 1;
> 
> 		rewind(fp);
> 		if (strbuf_fread(&new, (size_t)new_len, fp) != (size_t)new_len)
> 			goto release_return;
> 		if (strbuf_read_file(&old, path, 0) < 0)
> 			goto release_return;
> 
> 		diff = strbuf_cmp(&old, &new);
> 
> 	release_return:
> 		strbuf_release(&old);
> 		strbuf_release(&new);
> 
> 		return diff;
> 	}
> 
> I.e. optimze for code simplicity with something close to a dumb "cmp
> --silent". I'm going to make the bold claim that nobody using "dumb
> http" is going to be impacted by the performance of reading their
> for-each-ref or for-each-pack dump, hence opting for not even bothing to
> stat() to get the size before reading.

I've been trying to improve dumb HTTP for more cases; actually.
(since it's much cheaper than smart HTTP in server memory/CPU)

> Because really, if we were *trying* to micro-optimize this for time or
> memory use there's much better ways, e.g. reading the old file and
> memcmp() as we go and stream the "generate" callback, but I just don't
> see the point of trying in this case.

I was actually going towards that route; but wasn't sure if this
idea would be accepted at all (and I've been trying to stay away
from using non-scripting languages).

I don't slurping all of info/refs into memory at all; so maybe
a streaming memcmp of the existing file is worth doing...

> >  /*
> >   * Create the file "path" by writing to a temporary file and renaming
> >   * it into place. The contents of the file come from "generate", which
> >   * should return non-zero if it encounters an error.
> >   */
> > -static int update_info_file(char *path, int (*generate)(FILE *))
> > +static int update_info_file(char *path, int (*generate)(FILE *), int force)
> >  {
> >  	char *tmp = mkpathdup("%s_XXXXXX", path);
> 
> Unrelated to this, patch, but I hadn't thought about this nasty race
> condition. We recommend users run this from the "post-update" (or
> "post-receive") hook, and don't juggle the lock along with the ref
> update, thus due to the vagaries of scheduling you can end up with two
> concurrent ref updates where the "old" one wins.
> 
> But I guess that brings me back to something close to "nobody with that
> sort of update rate is using 'dumb http'" :)
> 
> For this to work properly we'd need to take some sort of global "ref
> update/pack update" lock, and I guess at that point this "cmp" case
> would be a helper similar to commit_lock_file_to(),
> i.e. a commit_lock_file_to_if_different().

Worth a separate patch, at some point, I think.  I'm not too
familiar with the existing locking in git, actually...

Along those lines, I think repack/gc should automatically
update objects/info/packs if the file already exists.

> >  	int ret = -1;
> >  	int fd = -1;
> >  	FILE *fp = NULL, *to_close;
> > +	int do_update;
> >
> >  	safe_create_leading_directories(path);
> >  	fd = git_mkstemp_mode(tmp, 0666);
> >  	if (fd < 0)
> >  		goto out;
> > -	to_close = fp = fdopen(fd, "w");
> > +	to_close = fp = fdopen(fd, "w+");
> >  	if (!fp)
> >  		goto out;
> >  	fd = -1;
> >  	ret = generate(fp);
> >  	if (ret)
> >  		goto out;
> > +
> > +	do_update = force || files_differ(fp, path);
> > [...]
> >
> > -static int update_info_refs(void)
> > +static int update_info_refs(int force)
> 
> So, I was going to say "shouldn't we update the docs?" which for --force
> say "Update the info files from scratch.".
> 
> But reading through it that "from scratch" wording is from c743e6e3c0
> ("Add a link from update-server-info documentation to repository
> layout.", 2005-09-04).

Yes, that wording is awkward and I can update it.  But maybe making
it undocumented is sufficient and would save us the trouble
of describing it :)

"--force" might be seen as a performance optimization for cases
where you're certain the result will differ, but I'm not
sure if that's worth mentioning in the manpage.

> There it was a refrence to a bug since fixed in 60d0526aaa ("Unoptimize
> info/refs creation.", 2005-09-14), and then removed from the docs in
> c5fe5b6de9 ("Remove obsolete bug warning in man git-update-server-info",
> 2009-04-25).
> 
> Then in b3223761c8 ("update_info_refs(): drop unused force parameter",
> 2019-04-05) Jeff removed the unused-for-a-decade "force" param.
> 
> So having gone through the history I think we're better off just
> dropping the --force argument entirely, or at least changing the
> docs.

I can update the docs, or make it undocumented.  Compatibility
from the command-line needs to remain in case there are scripts
using it.
