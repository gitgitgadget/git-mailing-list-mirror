From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Tue, 05 Sep 2006 12:23:58 -0700
Message-ID: <7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 21:24:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKgWD-00014C-4u
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 21:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWIETX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIETX3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 15:23:29 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47091 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932115AbWIETX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 15:23:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905192326.NEXD2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 15:23:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JjPT1V00N1kojtg0000000
	Tue, 05 Sep 2006 15:23:27 -0400
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26484>

"Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:

> git-archive is a command to make TAR and ZIP archives of a git tree.
> It helps prevent a proliferation of git-{format}-tree commands.

Thanks.  I like the overall structure, at least mostly.
Also dropping -tree suffix from the command name is nice, short
and sweet.

Obviously I cannot apply this patch because it is totally
whitespace damaged, but here are some comments.

> diff --git a/archive.h b/archive.h
> new file mode 100644
> index 0000000..6c69953
> --- /dev/null
> +++ b/archive.h
> @@ -0,0 +1,43 @@
> +#ifndef ARCHIVE_H
> +#define ARCHIVE_H
> +
> +typedef int (*write_archive_fn_t)(struct tree *tree,
> +				  const unsigned char *commit_sha1,
> +				  const char *prefix,
> +				  time_t time,
> +				  const char **pathspec);

The type of the first argument might have to be different,
depending on performance analysis by Rene on struct tree vs
struct tree_desc.

> +typedef int (*parse_extra_args_fn_t)(int argc,
> +				     const char **argv,
> +				     const char **reason);
> +

I do not see a way for parse_extra to record the parameter it
successfully parsed, other than in a source-file-global, static
variable.  Not a very nice design for a library, if we are
building one from scratch.

Also, you are passing "reason" around from everywhere, but that
is used by the caller to pass it to error(), so it might be
simpler to just call error() when you want to assign to *reason,
and make an error return.  The caller does not have to do
anything if you do that.  Your way might interact with the
remote protocol better, though -- I haven't thought this part
through yet so do not take this as a serious objection, but just
a comment.

> +struct archiver_struct {
> +	const char *name;
> +	write_archive_fn_t write_archive;
> +	parse_extra_args_fn_t parse_extra;
> +	const char *remote;
> +	const char *prefix;
> +};

Somehow "struct foo_struct" makes me feel uneasy, when I do not
see the reason to call it "struct foo".

Also, the first three fields are permanent property of the
archiver while two are to wrap runtime arguments of one
particular invocation.  I would have liked...

> +extern struct archiver_struct archivers[];

... this array to have only the former, and a separate structure
"struct archive_args" to be defined.

	struct archive_args {
        	const char *remote;
                const char *prefix;
	};

After parse_archive_args finds the archiver specified with
--format=*, it can call its parse_extra to retrieve a suitable
struct that has struct archive_args embedded at the beginning,
and then set remote and prefix on the returned structure.

Then a specific parse_extra implementation can be written like this:

	static struct tar_archive_args {
        	struct archive_args a;
                int z_compress;
                ...
	};

	struct archive_args *
        tar_archive_parse_extra(int ac, const char **av)
	{
        	struct tar_archive_args *args = xcalloc(1, sizeof(*args));

		while (ac--) {
			const char *arg = *++av;
                	if (arg[0] == '-' &&
                            '0' <= arg[1] && arg[1] <= '9')
				args->z_compress = arg[1] - '0';
			...
		}
		return (struct archive_args *)args;
	}

and this can be passed to tar_archive_write_archive as an
argument.

> +extern int parse_treeish_arg(const char **argv,
> +			     struct tree **tree,
> +			     const unsigned char **commit_sha1,
> +			     time_t *archive_time,
> +			     const char *prefix,
> +			     const char **reason);
> +extern int write_tar_archive(struct tree *tree,
> +			     const unsigned char *commit_sha1,
> +			     const char *prefix,
> +			     time_t time,
> +			     const char **pathspec);

I suspect we would want "struct tree_desc" based interface,
instead of "struct tree".

> +static const char archive_usage[] = \
> +"git-archive --format=<fmt> [--prefix=<prefix>/] [-0|...|-9]
> <tree-ish> [path...]";

I do not think "-[0-9]" belongs to generic "git-archive".  It
does not make much sense to run compress on zip output.  More
like:

git-archive --format=<fmt> [--prefix=<prefix>] [format specific options] <tree-ish> [path...]

It has one potential advantage, though -- git-daemon _could_
look at it and notice that the client asks for too expensive
compression level.  But I do not think it is the only way to
achive that to make "-[0-9]" a generic option.

> +static int run_remote_archiver(struct archiver_struct *ar, int argc,
> +			       const char **argv)
> +{
> +	char *url, buf[1024];
> +	pid_t pid;
> +	int fd[2];
> +	int len, rv;
> +
> +	sprintf(buf, "git-upload-%s", ar->name);

Are you calling git-upload-{tar,zip,rar,...} here?

> +	url = strdup(ar->remote);
> +	pid = git_connect(fd, url, buf);
> +	if (pid < 0)
> +		return pid;
> +
> +	concat_argv(argc, argv, buf, sizeof(buf));
> +	packet_write(fd[1], "arguments %s\n", buf);
> +	packet_flush(fd[1]);

Parameter concatenation with SP is a bad idea for two reasons.
You cannot have SP in argument.  Also packet_write() may not
like the length of the arguments.

A sequence of one argument per packet, with prefix "argument "
for future extension so that we can send other stuff if/when
needed, followed by a flush would be preferred.

> +	/* Now, start reading from fd[0] and spit it out to stdout */
> +	rv = copy_fd(fd[0], 1);
> +	close(fd[0]);
> +	rv |= finish_connect(pid);

It was painful to bolt progress indicator support onto original
upload-pack protocol, while making sure that older and newer
clients and servers interoperate with each other.  Since this is
a new protocol, we should start with the side-band support from
the beginning (see upload-pack and look for use_sideband).

Instead of sending the payload straight out, upload-archive side
would read from the underlying archiver, and send it with
one-byte prefix to say if it is a normal payload (band 1),
message to stderr used to show progress indicator and error
messages (band 2), or error exit situation (band 3).  The client
side here would receive the packetized data and do the reverse.

> +int parse_treeish_arg(const char **argv, struct tree **tree,
> +		      const unsigned char **commit_sha1,
> +		      time_t *archive_time, const char *prefix,
> +		      const char **reason)
> +{
>...
> +	if (prefix) {
> +		unsigned char tree_sha1[20];
> +		unsigned int mode;
> +		int err;
> +
> +		err = get_tree_entry((*tree)->object.sha1, prefix,
> +				     tree_sha1, &mode);
> +		if (err || !S_ISDIR(mode)) {
> +			*reason = "current working directory is untracked";
> +			goto out;
> +		}
> +		free(*tree);
> +		*tree = parse_tree_indirect(tree_sha1);
> +	}

I like the simplicity of just optionally sending one subtree (or
the whole thing), but I think this part would be made more
efficient if we go with "struct tree_desc" based interface.

Also I wonder how this interacts with the pathspec you take from
the command line.  Personally I think this single subtree
support is good enough and limiting with pathspec is not needed.

> +int parse_archive_args(int argc, const char **argv,
> +		       struct archiver_struct **ar,
> +		       const char **reason)
> +{
>...
> +		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0') {
> +			zlib_compression_level = arg[1] - '0';
> +			continue;
> +		}

Commented on this part already.

> +	if (list) {
> +		if (!remote) {
> +			int i;
> +
> +			for (i = 0; i < ARRAY_SIZE(archivers); i++)
> +				printf("%s\n", archivers[i].name);
> +			exit(0);
> +		}

You do not need a different "i" that shadows the outer one here.

> +	(*ar)->remote = remote;
> +	(*ar)->prefix = prefix ? : "";

Please be nicer to other people by staying away from GNU
extension "A ? : B", especially when A is so simple.
