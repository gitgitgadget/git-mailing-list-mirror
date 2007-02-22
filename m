From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 17:17:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702221656490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xeqllxk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 17:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKGdy-0000P2-M0
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 17:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbXBVQSD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 11:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbXBVQSD
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 11:18:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:46123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750763AbXBVQSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 11:18:00 -0500
Received: (qmail invoked by alias); 22 Feb 2007 16:17:58 -0000
X-Provags-ID: V01U2FsdGVkX1/MR8NFDSDMuziDCm4T8w0tFTBbsNQDl25k6JPkiH
	ODNA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xeqllxk.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40354>

Hi,

On Wed, 21 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It was updated to make git-bundle a builtin, and get rid of the tar 
> > format: now, the first line is supposed to say "# v2 git bundle", the next 
> > lines either contain a prerequisite ("-" followed by the hash of the 
> > needed commit), or a ref (the hash of a commit, followed by the name of 
> > the ref), and finally the pack. As a result, the bundle argument can be 
> > "-" now.
> 
> That in BNF would be?
> 
> 	bundle = signature prereq* ref* pack

more like

	bundle = header pack
	header = signature prereq* ref* nl

> I suspect that we might want to possibly:
> 
>  - have checksum protection over the part before pack data?

Possibly. But would the sha1's not be sufficient? I.e. if the header is 
corrupted, chances are that the commits are no longer verified correctly.

>  - give descriptive name to prereq, so that an error message can
>    say "you need v1.4.4" instead of "you need e267c2f6"?

My idea was to allow --since=<date>. You don't have a name there.

>  - make the fields extensible without updating "v2"?

You mean, like, warn about unknown header lines? Yes, that's really easy.

> > diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
> > index a2d6268..f61c77a 100755
> > --- a/Documentation/cmd-list.perl
> > +++ b/Documentation/cmd-list.perl
> > @@ -70,6 +70,7 @@ git-archive                             mainporcelain
> >  git-bisect                              mainporcelain
> >  git-blame                               ancillaryinterrogators
> >  git-branch                              mainporcelain
> > +git-bundle                              mainporcelain
> >  git-cat-file                            plumbinginterrogators
> >  git-checkout-index                      plumbingmanipulators
> >  git-checkout                            mainporcelain
> 
> Is this really a mainporcelain?

git bundle create <file>?

> > diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> > new file mode 100644
> > index 0000000..4ea9e85
> > ...
> > +Author
> > +------
> > +Written by Mark Levedahl <mdl123@verizon.net>
> 
> ... and Dscho.

... not the Documentation (only patched a little to reflect the "--" 
change).

> > diff --git a/builtin-bundle.c b/builtin-bundle.c
> > new file mode 100644
> > index 0000000..4bd596a
> > --- /dev/null
> > +++ b/builtin-bundle.c
> > ...
> > +static const char *bundle_usage="git-bundle (--create <bundle> <git-rev-list args> | --verify <bundle> | --list-heads <bundle> [refname]... | --unbundle <bundle> [refname]... )";
> 
> I thought you removed "--" prefixes from subcommands.

Yes, and I forgot it there. Will fix.

> > +struct bundle_header {
> > +	struct ref_list prerequisites, references;
> > +};
> 
> (minor style) I find these two members each on its own line
> easier to read, as in:
> 
>         struct bundle_header {
>                 struct ref_list prerequisites;
>                 struct ref_list references;
>         };

Will fix.

> > +/* this function returns the length of the string */
> > +static int read_string(int fd, char *buffer, int size)
> > +{
> > +	int i;
> > +	for (i = 0; i < size - 1; i++) {
> > +		int count = read(fd, buffer + i, 1);
> > +		if (count < 0)
> > +			return error("Read error: %s", strerror(errno));
> > +		if (count == 0) {
> > +			i--;
> > +			break;
> > +		}
> > +		if (buffer[i] == '\n')
> > +			break;
> > +	}
> > +	buffer[i + 1] = '\0';
> > +	return i + 1;
> > +}
> 
> At least xread() please.  I know the reason you read one byte at
> a time is because you cannot over-read into pack area, but
> somehow this makes me go "hmmmmmm".  It's not performance
> critical so let's leave it that way.  Is bundle supposed to be
> streamable?  Otherwise we could probably seek back.

I wanted unbundle to be able to read from stdin (I did not yet allow "git 
fetch - master:master"). But I somehow forgot about xread(). D'oh. Will 
fix.

> > +/* returns an fd */
> > +static int read_header(const char *path, struct bundle_header *header) {
> > +	char buffer[1024];
> > +	int fd = open(path, O_RDONLY);
> > +
> > +	if (fd < 0)
> > +		return error("could not open '%s'", path);
> > +	if (read_string(fd, buffer, sizeof(buffer)) < 0 ||
> > +			strcmp(buffer, bundle_signature)) {
> > +		close(fd);
> > +		return error("'%s' does not look like a v2 bundle file", path);
> > +	}
> > +	while (read_string(fd, buffer, sizeof(buffer)) > 0
> > +			&& buffer[0] != '\n') {
> > +		int offset = buffer[0] == '-' ? 1 : 0;
> > +		int len = strlen(buffer);
> > +		unsigned char sha1[20];
> > +		struct ref_list *list = offset ? &header->prerequisites
> > +			: &header->references;
> > +		if (get_sha1_hex(buffer + offset, sha1)) {
> > +			close(fd);
> > +			return error("invalid SHA1: %s", buffer);
> > +		}
> > +		if (buffer[len - 1] == '\n')
> > +			buffer[len - 1] = '\0';
> > +		add_to_ref_list(sha1, buffer + 41 + offset, list);
> > +	}
> > +	return fd;
> > +}
> 
> Don't you want to look at and validate buffer[40+offset] in any
> way, other than what get_sha1_hex() does (which is issspace())?

Right. Will fix. (Although I will only write two "s" instead of three...)

> > +/* if in && *in >= 0, take that as input file descriptor instead */
> > +static int fork_with_pipe(const char **argv, int *in, int *out)
> > +{
> > +	int needs_in, needs_out;
> > +	int fdin[2], fdout[2], pid;
> > +
> > +	needs_in = in && *in < 0;
> > +	if (needs_in) {
> > +		if (pipe(fdin) < 0)
> > +			return error("could not setup pipe");
> > +		*in = fdin[1];
> > +	}
> > +
> > +	needs_out = out && *out < 0;
> > +	if (needs_out) {
> > +		if (pipe(fdout) < 0)
> > +			return error("could not setup pipe");
> > +		*out = fdout[0];
> > +	}
> > +
> > +	if ((pid = fork()) < 0) {
> > +		if (needs_in) {
> > +			close(fdin[0]);
> > +			close(fdin[1]);
> > +		}
> > +		if (needs_out) {
> > +			close(fdout[0]);
> > +			close(fdout[1]);
> > +		}
> > +		return error("could not fork");
> > +	}
> > +	if (!pid) {
> > +		if (needs_in) {
> > +			dup2(fdin[0], 0);
> > +			close(fdin[0]);
> > +			close(fdin[1]);
> > +		} else if (in)
> > +			dup2(*in, 0);
> > +		if (needs_out) {
> > +			dup2(fdout[1], 1);
> > +			close(fdout[0]);
> > +			close(fdout[1]);
> > +		} else if (out)
> > +			dup2(*out, 1);
> > +		exit(execv_git_cmd(argv));
> > +	}
> 
> Do you need to close *in and *out that are given by the caller
> after dup2() in the child?

I probably should. Will fix.

> > +static int verify_bundle(struct bundle_header *header)
> > +{
> > +	/*
> > +	 * Do fast check, then if any prereqs are missing then go line by line
> > +	 * to be verbose about the errors
> > +	 */
> > +	struct ref_list *p = &header->prerequisites;
> > +	const char *argv[5] = {"rev-list", "--stdin", "--not", "--all", NULL};
> > +	int pid, in, out, i, ret = 0;
> > +	char buffer[1024];
> > +
> > +	in = out = -1;
> > +	pid = fork_with_pipe(argv, &in, &out);
> > +	if (pid < 0)
> > +		return error("Could not fork rev-list");
> > +	if (!fork()) {
> > +		for (i = 0; i < p->nr; i++) {
> > +			write(in, sha1_to_hex(p->list[i].sha1), 40);
> > +			write(in, "\n", 1);
> > +		}
> > +		close(in);
> > +		exit(0);
> > +	}
> > +	close(in);
> 
> What if write() fails?  That can happen when one of the objects
> you feed here, or its parent objects, is missing from your
> repository -- receiving rev-list would die() and the writing
> child would sigpipe.

The error is caught afterwards, with WEXITSTATUS(), no? It might be 
cleaner to check, but is it really necessary?

> I also wonder who waits for this child...

rev-list. It only exits when that child closes the input.

> > +	while (read_string(out, buffer, sizeof(buffer)) > 0) {
> > +		if (ret++ == 0)
> > +			error ("The bundle requires the following commits you lack:");
> > +		fprintf(stderr, "%s", buffer);
> > +	}
> > +	close(out);
> 
> I do not think this error message would buy you anything.  If
> you say:
> 
> 	echo commit | rev-list --stdin --not --all
> 
> and you got commit back, that means you _do_ have that commit,
> and that commit reaches some ref you have (objects associated to
> that commit may be still missing).  If commit is truly missing,
> then you do not get commit output from rev-list as it cannot
> even determine if it is "--not --all" or not -- it would error
> out, which is the more important check to see if prereqs are
> lacking.

Yes, I realized that rev-list die()s, and does not output the missing 
revs -- as git-bundle.sh expected it to. When I found out about that, I 
failed to remove that bogus error. Will fix.

> > +	while (waitpid(pid, &i, 0) < 0)
> > +		if (errno != EINTR)
> > +			return -1;
> > +	if (!ret && (!WIFEXITED(i) || WEXITSTATUS(i)))
> > +		return error("At least one prerequisite is lacking.");
> 
> So you would want to keep this error, perhaps even make it more
> helpful by suggesting which ones are missing.

rev-list die()s with the first missing. It does not continue, printing 
other missing revs.

> > +static int list_heads(struct bundle_header *header, int argc, const char **argv)
> > +{
> > +	int i;
> > +	struct ref_list *r = &header->references;
> > +
> > +	for (i = 0; i < r->nr; i++) {
> > +		if (argc > 1) {
> > +			int j;
> > +			for (j = 1; j < argc; j++)
> > +				if (!strcmp(r->list[i].name, argv[j]))
> > +					break;
> > +			if (j == argc)
> > +				continue;
> > +		}
> > +		printf("%s %s\n", sha1_to_hex(r->list[i].sha1),
> > +				r->list[i].name);
> > +	}
> > +	return 0;
> > +}
> 
> I wonder if we want to have a way to list prereqs in similar way.

That is what verify should be for. Maybe add "-v" to the "verify" 
subcommand, make it properly builtin, and output non-missing prerequisites 
only with "-v"?

> > +static void show_commit(struct commit *commit)
> > +{
> > +	write(1, sha1_to_hex(commit->object.sha1), 40);
> > +	write(1, "\n", 1);
> > +	if (commit->parents) {
> > +		free_commit_list(commit->parents);
> > +		commit->parents = NULL;
> > +	}
> > +}
> 
> (everywhere) We would want write_in_full() with error handling
> that dies even on EPIPE.

Or write_or_die()? I mean, if write() fails, we cannot sanely continue 
anyway, right?

> > +static void show_object(struct object_array_entry *p)
> > +{
> > +	/* An object with name "foo\n0000000..." can be used to
> > +	 *          * confuse downstream git-pack-objects very badly.
> > +	 *                   */
> 
> An interesting way to wrap comments.

Bad, bad vi. Will fix.

> > +	/* write prerequisites */
> > +	memcpy(argv_boundary + 2, argv + 1, argc * sizeof(const char *));
> > +	argv_boundary[0] = "rev-list";
> > +	argv_boundary[1] = "--boundary";
> > +	argv_boundary[argc + 1] = NULL;
> > +	out = -1;
> > +	pid = fork_with_pipe(argv_boundary, NULL, &out);
> > +	if (pid < 0)
> > +		return -1;
> > +	while ((i = read_string(out, buffer, sizeof(buffer))) > 0)
> > +		if (buffer[0] == '-')
> > +			write(bundle_fd, buffer, i);
> 
> It would be helpful for the recipient if you can append output
> >from git-describe (or name-rev) when the buffer lacks "name".

Hmm. This could take a long time, as -describe is not really fast. ATM 
name-rev is not fast either, but I have plans to make it so. So obiously, 
I would prefer name-rev output. Comments?

> > +static int unbundle(struct bundle_header *header, int bundle_fd,
> > +		int argc, const char **argv)
> > +{
> > +	const char *argv_index_pack[] = {"index-pack", "--stdin", NULL};
> > +	int pid, status, dev_null;
> > +
> > +	if (verify_bundle(header))
> > +		return -1;
> > +	dev_null = open("/dev/null", O_WRONLY);
> > +	pid = fork_with_pipe(argv_index_pack, &bundle_fd, &dev_null);
> > +	if (pid < 0)
> > +		return error("Could not spawn index-pack");
> > +	close(bundle_fd);
> > +	while (waitpid(pid, &status, 0) < 0)
> > +		if (errno != EINTR)
> > +			return error("index-pack died");
> > +	if (!WIFEXITED(status) || WEXITSTATUS(status))
> > +		return error("index-pack exited with status %d",
> > +				WEXITSTATUS(status));
> > +	return list_heads(header, argc, argv);
> > +}
> 
> We might want to later use --keep for this as well...

Yes, later. It is such a low-hanging fruit that I'd prefer somebody else 
to get involved with the code.

> > diff --git a/index-pack.c b/index-pack.c
> > index fa9a0e7..5ccf4c4 100644
> > --- a/index-pack.c
> > +++ b/index-pack.c
> > @@ -457,8 +457,8 @@ static void parse_pack_objects(unsigned char *sha1)
> >  	/* If input_fd is a file, we should have reached its end now. */
> >  	if (fstat(input_fd, &st))
> >  		die("cannot fstat packfile: %s", strerror(errno));
> > -	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
> > -		die("pack has junk at the end");
> > +	if (input_fd && S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
> > +		die("pack has junk at the end: 0%o, %d, %d %d", st.st_mode, (int)st.st_size, (int)consumed_bytes, input_fd);
> >  
> >  	if (!nr_deltas)
> >  		return;
> 
> ??

As I said in my reply to Nico, if input_fd is 0, but really comes from a 
file, this check will fail (the bundle is _strictly_ larger than the 
pack).

Would you like the fixes on top of the big commit, or a replacement patch?

Ciao,
Dscho
