From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Wed, 06 Sep 2006 15:46:22 +0200
Message-ID: <44FED12E.7010409@innova-card.com>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com> <7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org,
	rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Wed Sep 06 15:47:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKxkR-00066t-RP
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWIFNqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWIFNqU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:46:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:48475 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751022AbWIFNqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 09:46:14 -0400
Received: by nf-out-0910.google.com with SMTP id a25so209309nfc
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 06:46:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=edsI7Vi95JnxS2C4OaYwq6T8I1XcXkvmd/2YP7KPEYhixlHZ+PM9tAz7wD30MKwDPcT644jxsOqnbpYyXpqCBddXcX+PE4G4ooUvfpgYLE7pn9a6v8XXIKnce1q7yuRAf0ocvr+twAHLDFSXBhr+iX9GbDBkDt1Q19IG9h7illo=
Received: by 10.65.185.3 with SMTP id m3mr6292219qbp;
        Wed, 06 Sep 2006 06:46:13 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id f13sm4254695qba.2006.09.06.06.46.11;
        Wed, 06 Sep 2006 06:46:12 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26531>

Junio C Hamano wrote:
> "Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:
> 
>> git-archive is a command to make TAR and ZIP archives of a git tree.
>> It helps prevent a proliferation of git-{format}-tree commands.
> 
> Thanks.  I like the overall structure, at least mostly.
> Also dropping -tree suffix from the command name is nice, short
> and sweet.
> 

great !

> Obviously I cannot apply this patch because it is totally
> whitespace damaged, but here are some comments.

(sigh), sorry for that.

> 
>> diff --git a/archive.h b/archive.h
>> new file mode 100644
>> index 0000000..6c69953
>> --- /dev/null
>> +++ b/archive.h
>> @@ -0,0 +1,43 @@
>> +#ifndef ARCHIVE_H
>> +#define ARCHIVE_H
>> +
>> +typedef int (*write_archive_fn_t)(struct tree *tree,
>> +				  const unsigned char *commit_sha1,
>> +				  const char *prefix,
>> +				  time_t time,
>> +				  const char **pathspec);
> 
> The type of the first argument might have to be different,
> depending on performance analysis by Rene on struct tree vs
> struct tree_desc.
> 

OK. We'll wait for Rene.

>> +typedef int (*parse_extra_args_fn_t)(int argc,
>> +				     const char **argv,
>> +				     const char **reason);
>> +
> 
> I do not see a way for parse_extra to record the parameter it
> successfully parsed, other than in a source-file-global, static
> variable.  Not a very nice design for a library, if we are
> building one from scratch.
> 

Interesting, could you explain why static variables are not nice ?

> Also, you are passing "reason" around from everywhere, but that
> is used by the caller to pass it to error(), so it might be
> simpler to just call error() when you want to assign to *reason,
> and make an error return.  The caller does not have to do
> anything if you do that.  Your way might interact with the
> remote protocol better, though -- I haven't thought this part
> through yet so do not take this as a serious objection, but just
> a comment.
> 

You might have missed my second patch:

		"[PATCH 2/2] Add git-upload-archive"

Basically the server can also use 'reason' to report a failure
description during NACK. I find it more useful than the simple
"server sent EOF" error message.

>> +struct archiver_struct {
>> +	const char *name;
>> +	write_archive_fn_t write_archive;
>> +	parse_extra_args_fn_t parse_extra;
>> +	const char *remote;
>> +	const char *prefix;
>> +};
> 
> Somehow "struct foo_struct" makes me feel uneasy, when I do not
> see the reason to call it "struct foo".
> 

no strong feeling here. I'll call it "struct archiver". BTW there
are a couple of "struct foo_struct" in git source...

> Also, the first three fields are permanent property of the
> archiver while two are to wrap runtime arguments of one
> particular invocation.  I would have liked...
> 

'remote' case is not a generic argument that can be passed to
archiver backends. Remember, the archiver backends only do local
operation. They do not know about remote protocol which is part
of git-archive command. That's the reason why I think we shouldn't
make this field part of arguments structure. It completely change
the behaviour of git-archive when it is used.

>> +extern struct archiver_struct archivers[];
> 
> ... this array to have only the former, and a separate structure
> "struct archive_args" to be defined.
> 
> 	struct archive_args {
>         	const char *remote;
>                 const char *prefix;
> 	};
> 
> After parse_archive_args finds the archiver specified with
> --format=*, it can call its parse_extra to retrieve a suitable
> struct that has struct archive_args embedded at the beginning,
> and then set remote and prefix on the returned structure.
> 

One bad side is that we need to malloc this embedded structure.
Therefore we have to free this embedded structure somewhere. 

We could have the following structures in archive.h, but we need
to export all these archiver backend definitions.

	struct tar_archive_args {
		int z_compress;
	};

	struct tar_archive_args {
		[...]
	};

	struct archive_args {
		const char		*prefix;
		struct tree		*tree;
		const unsigned char	*commit_sha1;
		const char		*prefix;
		time_t			time;
		const char		**pathspec;
		union {
			struct tar_archive_args tar_args;
			struct zip_archive_args zip_args;
		} u;
	};

	struct archiver {
		const char *name;
		write_archive_fn_t write_archive;
		parse_extra_args_fn_t parse_extra;
		const char *remote;
	};

	typedef int (*write_archive_fn_t)(struct archive_args *archive_args);

> Then a specific parse_extra implementation can be written like this:
> 
> 	static struct tar_archive_args {
>         	struct archive_args a;
>                 int z_compress;
>                 ...
> 	};
> 
> 	struct archive_args *
>         tar_archive_parse_extra(int ac, const char **av)
> 	{
>         	struct tar_archive_args *args = xcalloc(1, sizeof(*args));
> 
> 		while (ac--) {
> 			const char *arg = *++av;
>                 	if (arg[0] == '-' &&
>                             '0' <= arg[1] && arg[1] <= '9')
> 				args->z_compress = arg[1] - '0';
> 			...
> 		}
> 		return (struct archive_args *)args;
> 	}
> 
> and this can be passed to tar_archive_write_archive as an
> argument.
> 
>> +extern int parse_treeish_arg(const char **argv,
>> +			     struct tree **tree,
>> +			     const unsigned char **commit_sha1,
>> +			     time_t *archive_time,
>> +			     const char *prefix,
>> +			     const char **reason);
>> +extern int write_tar_archive(struct tree *tree,
>> +			     const unsigned char *commit_sha1,
>> +			     const char *prefix,
>> +			     time_t time,
>> +			     const char **pathspec);
> 
> I suspect we would want "struct tree_desc" based interface,
> instead of "struct tree".
> 
>> +static const char archive_usage[] = \
>> +"git-archive --format=<fmt> [--prefix=<prefix>/] [-0|...|-9]
>> <tree-ish> [path...]";
> 
> I do not think "-[0-9]" belongs to generic "git-archive".  It
> does not make much sense to run compress on zip output.  More
> like:
> 

I forgot to remove that.

> git-archive --format=<fmt> [--prefix=<prefix>] [format specific options] <tree-ish> [path...]
> 

I forgot to change that.

> 
>> +static int run_remote_archiver(struct archiver_struct *ar, int argc,
>> +			       const char **argv)
>> +{
>> +	char *url, buf[1024];
>> +	pid_t pid;
>> +	int fd[2];
>> +	int len, rv;
>> +
>> +	sprintf(buf, "git-upload-%s", ar->name);
> 
> Are you calling git-upload-{tar,zip,rar,...} here?
> 

yes. Actually git-upload-{tar,zip,...} commands are going to be
removed, but git-daemon know them as a daemon service. It will
map these services to the generic "git-upload-archive" command.
One benefit is that we could still disable TAR format and enable
TGZ one. Please take a look to the second patch that adds
git-upload-archive command.

>> +	url = strdup(ar->remote);
>> +	pid = git_connect(fd, url, buf);
>> +	if (pid < 0)
>> +		return pid;
>> +
>> +	concat_argv(argc, argv, buf, sizeof(buf));
>> +	packet_write(fd[1], "arguments %s\n", buf);
>> +	packet_flush(fd[1]);
> 
> Parameter concatenation with SP is a bad idea for two reasons.
> You cannot have SP in argument.  Also packet_write() may not
> like the length of the arguments.
> 
> A sequence of one argument per packet, with prefix "argument "
> for future extension so that we can send other stuff if/when
> needed, followed by a flush would be preferred.

Absolutely.

> 
>> +	/* Now, start reading from fd[0] and spit it out to stdout */
>> +	rv = copy_fd(fd[0], 1);
>> +	close(fd[0]);
>> +	rv |= finish_connect(pid);
> 
> It was painful to bolt progress indicator support onto original
> upload-pack protocol, while making sure that older and newer
> clients and servers interoperate with each other.  Since this is
> a new protocol, we should start with the side-band support from
> the beginning (see upload-pack and look for use_sideband).
> 
> Instead of sending the payload straight out, upload-archive side
> would read from the underlying archiver, and send it with
> one-byte prefix to say if it is a normal payload (band 1),
> message to stderr used to show progress indicator and error
> messages (band 2), or error exit situation (band 3).  The client
> side here would receive the packetized data and do the reverse.
> 

OK, I'll take a look

>> +int parse_treeish_arg(const char **argv, struct tree **tree,
>> +		      const unsigned char **commit_sha1,
>> +		      time_t *archive_time, const char *prefix,
>> +		      const char **reason)
>> +{
>> ...
>> +	if (prefix) {
>> +		unsigned char tree_sha1[20];
>> +		unsigned int mode;
>> +		int err;
>> +
>> +		err = get_tree_entry((*tree)->object.sha1, prefix,
>> +				     tree_sha1, &mode);
>> +		if (err || !S_ISDIR(mode)) {
>> +			*reason = "current working directory is untracked";
>> +			goto out;
>> +		}
>> +		free(*tree);
>> +		*tree = parse_tree_indirect(tree_sha1);
>> +	}
> 
> I like the simplicity of just optionally sending one subtree (or
> the whole thing), but I think this part would be made more
> efficient if we go with "struct tree_desc" based interface.
> 
> Also I wonder how this interacts with the pathspec you take from
> the command line.  Personally I think this single subtree
> support is good enough and limiting with pathspec is not needed.
> 

As I said in a previous email, I'm new with git internals. I prefer
let that part to others who better have a better knowledge on the
subject. I'll dig into that later though...

>> +int parse_archive_args(int argc, const char **argv,
>> +		       struct archiver_struct **ar,
>> +		       const char **reason)
>> +{
>> ...
>> +		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0') {
>> +			zlib_compression_level = arg[1] - '0';
>> +			continue;
>> +		}
> 
> Commented on this part already.
> 

OK

>> +	if (list) {
>> +		if (!remote) {
>> +			int i;
>> +
>> +			for (i = 0; i < ARRAY_SIZE(archivers); i++)
>> +				printf("%s\n", archivers[i].name);
>> +			exit(0);
>> +		}
> 
> You do not need a different "i" that shadows the outer one here.

Yes.

> 
>> +	(*ar)->remote = remote;
>> +	(*ar)->prefix = prefix ? : "";
> 
> Please be nicer to other people by staying away from GNU
> extension "A ? : B", especially when A is so simple.
> 
sure.

Thanks for your comments,

		Franck
