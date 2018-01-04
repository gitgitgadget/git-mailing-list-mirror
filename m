Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746DB1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeADTzt (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:55:49 -0500
Received: from siwi.pair.com ([209.68.5.199]:63418 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751946AbeADTzs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:55:48 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 736CC844A7;
        Thu,  4 Jan 2018 14:55:47 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 838D3844A5;
        Thu,  4 Jan 2018 14:55:46 -0500 (EST)
Subject: Re: [PATCH 15/40] external-odb: add script mode support
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-16-chriscool@tuxfamily.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ebf67bcc-3e17-3fda-9f56-dd152e7bf3af@jeffhostetler.com>
Date:   Thu, 4 Jan 2018 14:55:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180103163403.11303-16-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/3/2018 11:33 AM, Christian Couder wrote:
> This adds support for the script command mode where
> an helper script or command is called to retrieve or
> manage objects.
> 
> This implements the 'have' and 'get_git_obj'
> instructions for the script mode.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   external-odb.c          |  51 ++++++++++-
>   external-odb.h          |   1 +
>   odb-helper.c            | 218 +++++++++++++++++++++++++++++++++++++++++++++++-
>   odb-helper.h            |   4 +
>   sha1_file.c             |  12 ++-
>   t/t0400-external-odb.sh |  44 ++++++++++
>   6 files changed, 327 insertions(+), 3 deletions(-)
>   create mode 100755 t/t0400-external-odb.sh
> 
> diff --git a/external-odb.c b/external-odb.c
> index 5d0afb9762..81f2aa5fac 100644
> --- a/external-odb.c
> +++ b/external-odb.c
> @@ -33,8 +33,14 @@ static int external_odb_config(const char *var, const char *value, void *data)
>   
>   	o = find_or_create_helper(name, namelen);
>   
> -	if (!strcmp(subkey, "promisorremote"))
> +	if (!strcmp(subkey, "promisorremote")) {
> +		o->type = ODB_HELPER_GIT_REMOTE;
>   		return git_config_string(&o->dealer, var, value);
> +	}
> +	if (!strcmp(subkey, "scriptcommand")) {
> +		o->type = ODB_HELPER_SCRIPT_CMD;
> +		return git_config_string(&o->dealer, var, value);
> +	}
>   
>   	return 0;
>   }
> @@ -77,6 +83,49 @@ int external_odb_has_object(const unsigned char *sha1)
>   	return 0;
>   }
>   
> +int external_odb_get_object(const unsigned char *sha1)
> +{
> +	struct odb_helper *o;
> +	const char *path;
> +
> +	if (!external_odb_has_object(sha1))
> +		return -1;
> +
> +	path = sha1_file_name_alt(external_odb_root(), sha1);
> +	safe_create_leading_directories_const(path);
> +	prepare_external_alt_odb();
> +
> +	for (o = helpers; o; o = o->next) {
> +		struct strbuf tmpfile = STRBUF_INIT;
> +		int ret;
> +		int fd;
> +
> +		if (!odb_helper_has_object(o, sha1))
> +			continue;
> +
> +		fd = create_object_tmpfile(&tmpfile, path);
> +		if (fd < 0) {
> +			strbuf_release(&tmpfile);
> +			return -1;
> +		}
> +
> +		if (odb_helper_get_object(o, sha1, fd) < 0) {
> +			close(fd);
> +			unlink(tmpfile.buf);
> +			strbuf_release(&tmpfile);
> +			continue;
> +		}
> +
> +		close_sha1_file(fd);
> +		ret = finalize_object_file(tmpfile.buf, path);
> +		strbuf_release(&tmpfile);
> +		if (!ret)
> +			return 0;
> +	}
> +
> +	return -1;
> +}
> +
>   int external_odb_get_direct(const unsigned char *sha1)
>   {
>   	struct odb_helper *o;
> diff --git a/external-odb.h b/external-odb.h
> index fd6708163e..fb8b94972f 100644
> --- a/external-odb.h
> +++ b/external-odb.h
> @@ -4,6 +4,7 @@
>   extern int has_external_odb(void);
>   extern const char *external_odb_root(void);
>   extern int external_odb_has_object(const unsigned char *sha1);
> +extern int external_odb_get_object(const unsigned char *sha1);
>   extern int external_odb_get_direct(const unsigned char *sha1);
>   
>   #endif /* EXTERNAL_ODB_H */
> diff --git a/odb-helper.c b/odb-helper.c
> index 4b70b287af..c1a3443dc7 100644
> --- a/odb-helper.c
> +++ b/odb-helper.c
> @@ -21,13 +21,124 @@ struct odb_helper_cmd {
>   	struct child_process child;
>   };
>   
> +/*
> + * Callers are responsible to ensure that the result of vaddf(fmt, ap)
> + * is properly shell-quoted.
> + */
> +static void prepare_helper_command(struct argv_array *argv, const char *cmd,
> +				   const char *fmt, va_list ap)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_addstr(&buf, cmd);
> +	strbuf_addch(&buf, ' ');
> +	strbuf_vaddf(&buf, fmt, ap);

I do find this a bit odd that you're putting the cmd, a space,
and the printf results into a single arg in the argv, rather than
directly loading up the argv.

Is there an issue with the whitespace between the cmd and the
printf result being in the same arg -- especially if there are
quoting issues in the fmt string as you mention in the comment
above?  (not sure, just asking)

> +
> +	argv_array_push(argv, buf.buf);
> +	strbuf_release(&buf);
> +}
> +
> +__attribute__((format (printf,3,4)))
> +static int odb_helper_start(struct odb_helper *o,
> +			    struct odb_helper_cmd *cmd,
> +			    const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	memset(cmd, 0, sizeof(*cmd));
> +	argv_array_init(&cmd->argv);
> +
> +	if (!o->dealer)
> +		return -1;
> +
> +	va_start(ap, fmt);
> +	prepare_helper_command(&cmd->argv, o->dealer, fmt, ap);
> +	va_end(ap);
> +
> +	cmd->child.argv = cmd->argv.argv;
> +	cmd->child.use_shell = 1;
> +	cmd->child.no_stdin = 1;
> +	cmd->child.out = -1;
> +
> +	if (start_command(&cmd->child) < 0) {
> +		argv_array_clear(&cmd->argv);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int odb_helper_finish(struct odb_helper *o,
> +			     struct odb_helper_cmd *cmd)
> +{
> +	int ret = finish_command(&cmd->child);
> +	argv_array_clear(&cmd->argv);
> +	if (ret) {
> +		warning("odb helper '%s' reported failure", o->name);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static int parse_object_line(struct odb_helper_object *o, const char *line)
> +{

Is there a reason to order the fields this way?  In the test
at the bottom of this commit, you take cat-file output and
re-order the columns with awk.   I'm just wondering if we kept
cat-file ordering in the format here, we could simplify things.

> +	char *end;
> +	if (get_sha1_hex(line, o->sha1) < 0)
> +		return -1;
> +
> +	line += 40;
> +	if (*line++ != ' ')
> +		return -1;
> +
> +	o->size = strtoul(line, &end, 10);
> +	if (line == end || *end++ != ' ')
> +		return -1;
> +
> +	o->type = type_from_string(end);
> +	return 0;
> +}
> +
> +static int add_have_entry(struct odb_helper *o, const char *line)
> +{
> +	ALLOC_GROW(o->have, o->have_nr+1, o->have_alloc);

I didn't see where o->have is initially allocated.  The default is
to start with 64 and then grow by 3/2 as needed.  If we are getting
lots of objects here, we'll have lots of reallocs slowing things down.
It would be better to seed it somewhere to a large value.


> +	if (parse_object_line(&o->have[o->have_nr], line) < 0) {
> +		warning("bad 'have' input from odb helper '%s': %s",
> +			o->name, line);
> +		return 1;
> +	}
> +	o->have_nr++;
> +	return 0;
> +}
> +
> +static int odb_helper_object_cmp(const void *va, const void *vb)
> +{
> +	const struct odb_helper_object *a = va, *b = vb;
> +	return hashcmp(a->sha1, b->sha1);
> +}
> +
>   static void odb_helper_load_have(struct odb_helper *o)
>   {
> +	struct odb_helper_cmd cmd;
> +	FILE *fh;
> +	struct strbuf line = STRBUF_INIT;
> +
>   	if (o->have_valid)
>   		return;
>   	o->have_valid = 1;
>   
> -	/* TODO */
> +	if (odb_helper_start(o, &cmd, "have") < 0)
> +		return;
> +
> +	fh = xfdopen(cmd.child.out, "r");
> +	while (strbuf_getline(&line, fh) != EOF)
> +		if (add_have_entry(o, line.buf))
> +			break;
> +
> +	strbuf_release(&line);
> +	fclose(fh);
> +	odb_helper_finish(o, &cmd);
> +
> +	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
>   }

Help me understand this.  I originally thought that the "have"
command would ask about one or more specific OIDs, but after a
couple of readings it looks like the "have" command is getting the
*complete* list of objects known to this external ODB and building
a sorted array of them.  And then we do this for each external ODB
configured.

If this is the case, I'm concerned that this will have scale problems.
"git cat-file..." shows that even my little git.git repo has 360K
objects.  And "time git cat-file..." takes over 1.1 seconds.

I'm wondering if there is a better/different way to do this.
(Sorry if you've already covered this in earlier versions of this
patch series and I missed it.)

I'm wondering about "struct odb_helper" maintain a long-running
connection to the sub-command which would let git ask for the object
and either get it back (as you have below) or get an not-found error.
The sub-command would then wait for another get-object request over
stdin.

I say this because whatever operation I'm doing (like a checkout or
log or blame) is only going to need a small percentage of the total
set of objects.  I think it would be more efficient to try/retry to
fault them in as-needed via one or more external helpers than to build
these tables in advance.


>   static const unsigned char *have_sha1_access(size_t index, void *table)
> @@ -53,6 +164,111 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
>   	return !!odb_helper_lookup(o, sha1);
>   }
>   
> +int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
> +			    int fd)
> +{
> +	struct odb_helper_object *obj;
> +	struct odb_helper_cmd cmd;
> +	unsigned long total_got;
> +	git_zstream stream;
> +	int zret = Z_STREAM_END;
> +	git_SHA_CTX hash;
> +	unsigned char real_sha1[20];
> +	struct strbuf header = STRBUF_INIT;
> +	unsigned long hdr_size;
> +
> +	obj = odb_helper_lookup(o, sha1);
> +	if (!obj)
> +		return -1;
> +
> +	if (odb_helper_start(o, &cmd, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
> +		return -1;
> +
> +	memset(&stream, 0, sizeof(stream));
> +	git_inflate_init(&stream);
> +	git_SHA1_Init(&hash);
> +	total_got = 0;
> +
> +	for (;;) {
> +		unsigned char buf[4096];
> +		int r;
> +
> +		r = xread(cmd.child.out, buf, sizeof(buf));
> +		if (r < 0) {
> +			error("unable to read from odb helper '%s': %s",
> +			      o->name, strerror(errno));
> +			close(cmd.child.out);
> +			odb_helper_finish(o, &cmd);
> +			git_inflate_end(&stream);
> +			return -1;
> +		}
> +		if (r == 0)
> +			break;
> +
> +		write_or_die(fd, buf, r);
> +
> +		stream.next_in = buf;
> +		stream.avail_in = r;
> +		do {
> +			unsigned char inflated[4096];
> +			unsigned long got;
> +
> +			stream.next_out = inflated;
> +			stream.avail_out = sizeof(inflated);
> +			zret = git_inflate(&stream, Z_SYNC_FLUSH);
> +			got = sizeof(inflated) - stream.avail_out;
> +
> +			git_SHA1_Update(&hash, inflated, got);
> +			/* skip header when counting size */
> +			if (!total_got) {
> +				const unsigned char *p = memchr(inflated, '\0', got);
> +				if (p) {
> +					unsigned long hdr_last = p - inflated + 1;
> +					strbuf_add(&header, inflated, hdr_last);
> +					got -= hdr_last;
> +				} else {
> +					strbuf_add(&header, inflated, got);
> +					got = 0;
> +				}
> +			}
> +			total_got += got;
> +		} while (stream.avail_in && zret == Z_OK);
> +	}
> +
> +	close(cmd.child.out);
> +	git_inflate_end(&stream);
> +	git_SHA1_Final(real_sha1, &hash);
> +	if (odb_helper_finish(o, &cmd))
> +		return -1;
> +	if (zret != Z_STREAM_END) {
> +		warning("bad zlib data from odb helper '%s' for %s",
> +			o->name, sha1_to_hex(sha1));
> +		return -1;
> +	}
> +	if (total_got != obj->size) {
> +		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
> +			o->name, sha1_to_hex(sha1), total_got, obj->size);
> +		return -1;
> +	}
> +	if (hashcmp(real_sha1, sha1)) {
> +		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
> +			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
> +		return -1;
> +	}
> +	if (parse_sha1_header(header.buf, &hdr_size) < 0) {
> +		warning("could not parse header from odb helper '%s' for %s",
> +			o->name, sha1_to_hex(sha1));
> +		return -1;
> +	}
> +	if (total_got != hdr_size) {
> +		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
> +			o->name, sha1_to_hex(sha1), total_got, hdr_size);
> +		return -1;
> +	}

Does "strbuf header" need to be released before all of the returns?

> +
> +	return 0;
> +}

If I understand this function, it is receiving an object from the odb
helper sub-command and creating a loose object for it in the local odb.
The object is compressed on the wire and this function unzips it to
verify the object is completely received and without errors.

But this function does not keep the resulting object around in memory
(which might not fit anyway).  I'm assuming that the higher-layer that
needs the object will just be told to read the new loose object.


>   int odb_helper_get_direct(struct odb_helper *o,
>   			  const unsigned char *sha1)
>   {
> diff --git a/odb-helper.h b/odb-helper.h
> index f4bc66b0ef..90b279c07e 100644
> --- a/odb-helper.h
> +++ b/odb-helper.h
> @@ -20,6 +20,10 @@ struct odb_helper {
>   extern struct odb_helper *odb_helper_new(const char *name, int namelen);
>   extern int odb_helper_has_object(struct odb_helper *o,
>   				 const unsigned char *sha1);
> +extern int odb_helper_get_object(struct odb_helper *o,
> +				 const unsigned char *sha1,
> +				 int fd);
>   extern int odb_helper_get_direct(struct odb_helper *o,
>   				 const unsigned char *sha1);
> +
>   #endif /* ODB_HELPER_H */
> diff --git a/sha1_file.c b/sha1_file.c
> index 785e8dda03..f1d688c10a 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -904,6 +904,9 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
>   			return 0;
>   	}
>   
> +	if (!external_odb_get_object(sha1) && !lstat(*path, st))
> +		return 0;
> +
>   	return -1;
>   }
>   
> @@ -939,7 +942,14 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
>   	if (fd >= 0)
>   		return fd;
>   
> -	return open_sha1_file_alt(sha1, path);
> +	fd = open_sha1_file_alt(sha1, path);
> +	if (fd >= 0)
> +		return fd;
> +
> +	if (!external_odb_get_object(sha1))
> +		fd = open_sha1_file_alt(sha1, path);
> +
> +	return fd;
>   }
>   
>   /*
> diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
> new file mode 100755
> index 0000000000..eaa3688a31
> --- /dev/null
> +++ b/t/t0400-external-odb.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +
> +test_description='basic tests for external object databases'
> +
> +. ./test-lib.sh
> +
> +ALT_SOURCE="$PWD/alt-repo/.git"
> +export ALT_SOURCE
> +write_script odb-helper <<\EOF
> +GIT_DIR=$ALT_SOURCE; export GIT_DIR
> +case "$1" in
> +have)
> +	git cat-file --batch-check --batch-all-objects |
> +	awk '{print $1 " " $3 " " $2}'
> +	;;
> +get_git_obj)
> +	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
> +	;;
> +esac
> +EOF
> +HELPER="\"$PWD\"/odb-helper"
> +
> +test_expect_success 'setup alternate repo' '
> +	git init alt-repo &&
> +	test_commit -C alt-repo one &&
> +	test_commit -C alt-repo two &&
> +	alt_head=$(git -C alt-repo rev-parse HEAD)
> +'
> +
> +test_expect_success 'alt objects are missing' '
> +	test_must_fail git log --format=%s $alt_head
> +'
> +
> +test_expect_success 'helper can retrieve alt objects' '
> +	test_config odb.magic.scriptCommand "$HELPER" &&
> +	cat >expect <<-\EOF &&
> +	two
> +	one
> +	EOF
> +	git log --format=%s $alt_head >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> 

Jeff

