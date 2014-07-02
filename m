From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 04/16] trace: improve trace performance
Date: Wed, 02 Jul 2014 11:15:52 -0700
Message-ID: <xmqqsimjhbjb.fsf@gitster.dls.corp.google.com>
References: <53B33C05.5090900@gmail.com> <53B33CD2.6000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBY4Y2GOQKGQEMKANTJQ@googlegroups.com Wed Jul 02 20:16:07 2014
Return-path: <msysgit+bncBCG77UMM3EJRBY4Y2GOQKGQEMKANTJQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBY4Y2GOQKGQEMKANTJQ@googlegroups.com>)
	id 1X2P4f-0003Ey-1g
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 20:16:05 +0200
Received: by mail-qc0-f186.google.com with SMTP id w7sf2602142qcr.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2014 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=qyNoO3h8chbOGatpZzqjRd/Z8/VvdmLA1/P90rxZEvI=;
        b=rJWiPfxekM0Elb2QV8yYUEzVvMxHOu0SWLHRtPKjzeu/XERNgnP6lbdXCHKRPMJV+4
         cavM/UHxD9clTjk+MwRv/Zvpan3I5d/izqTYbh2TUS/WWc+yTfefhIsfXODhX/s44C1k
         F82p3GIeG9yHIHiwCLjsF55WMMix97fOolpKiA2Eb7irHadXO8poAb5ikATSJ+0VeZPM
         c30INJuXg1SSRpYdTOXBk6G17IRA+kbsziGa6NSA0HCIOGKh2D19lwFXl7mWaiW2y4Fg
         Pj1avFnbp8o8VN5o86E44jQTC4TepyMIHczvYWpvrj0CsoArdgJI6JabLpKjM5dplRa8
         LEsQ==
X-Received: by 10.50.25.168 with SMTP id d8mr724831igg.1.1404324964285;
        Wed, 02 Jul 2014 11:16:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.131.229 with SMTP id op5ls219629igb.34.gmail; Wed, 02 Jul
 2014 11:16:03 -0700 (PDT)
X-Received: by 10.50.170.162 with SMTP id an2mr23219695igc.4.1404324963478;
        Wed, 02 Jul 2014 11:16:03 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id y50si1389439yhk.4.2014.07.02.11.16.03
        for <msysgit@googlegroups.com>;
        Wed, 02 Jul 2014 11:16:03 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CCE322203;
	Wed,  2 Jul 2014 14:15:51 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42CF222202;
	Wed,  2 Jul 2014 14:15:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A1022221FC;
	Wed,  2 Jul 2014 14:15:44 -0400 (EDT)
In-Reply-To: <53B33CD2.6000607@gmail.com> (Karsten Blees's message of "Wed, 02
	Jul 2014 00:57:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E244655E-0214-11E4-AC48-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252824>

Karsten Blees <karsten.blees@gmail.com> writes:

> Replace the 'const char *key' parameter in the API with a pointer to a
> 'struct trace_key' that bundles the environment variable name with
> additional, trace-internal state. Change the call sites of these APIs to
> use a static 'struct trace_key' instead of a string constant.

Nice.  Very nice ;-).

> In trace.c::get_trace_fd(), save and reuse the file descriptor in 'struct
> trace_key'.
>
> Add a 'trace_disable()' API, so that packet_trace() can cleanly disable
> tracing when it encounters packed data (instead of using unsetenv()).

Again, very nice.

> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>  builtin/receive-pack.c |   2 +-
>  commit.h               |   1 +
>  pkt-line.c             |   8 ++--
>  shallow.c              |  10 ++---
>  trace.c                | 100 ++++++++++++++++++++++++++-----------------------
>  trace.h                |  16 ++++++--
>  6 files changed, 78 insertions(+), 59 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index c323081..1451050 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -438,7 +438,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  	uint32_t mask = 1 << (cmd->index % 32);
>  	int i;
>  
> -	trace_printf_key("GIT_TRACE_SHALLOW",
> +	trace_printf_key(&trace_shallow,
>  			 "shallow: update_shallow_ref %s\n", cmd->ref_name);
>  	for (i = 0; i < si->shallow->nr; i++)
>  		if (si->used_shallow[i] &&
> diff --git a/commit.h b/commit.h
> index a9f177b..08ef643 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -235,6 +235,7 @@ extern void assign_shallow_commits_to_refs(struct shallow_info *info,
>  					   int *ref_status);
>  extern int delayed_reachability_test(struct shallow_info *si, int c);
>  extern void prune_shallow(int show_only);
> +extern struct trace_key trace_shallow;
>  
>  int is_descendant_of(struct commit *, struct commit_list *);
>  int in_merge_bases(struct commit *, struct commit *);
> diff --git a/pkt-line.c b/pkt-line.c
> index bc63b3b..8bc89b1 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -3,7 +3,7 @@
>  
>  char packet_buffer[LARGE_PACKET_MAX];
>  static const char *packet_trace_prefix = "git";
> -static const char trace_key[] = "GIT_TRACE_PACKET";
> +static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
>  
>  void packet_trace_identity(const char *prog)
>  {
> @@ -15,7 +15,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  	int i;
>  	struct strbuf out;
>  
> -	if (!trace_want(trace_key))
> +	if (!trace_want(&trace_packet))
>  		return;
>  
>  	/* +32 is just a guess for header + quoting */
> @@ -27,7 +27,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  	if ((len >= 4 && starts_with(buf, "PACK")) ||
>  	    (len >= 5 && starts_with(buf+1, "PACK"))) {
>  		strbuf_addstr(&out, "PACK ...");
> -		unsetenv(trace_key);
> +		trace_disable(&trace_packet);
>  	}
>  	else {
>  		/* XXX we should really handle printable utf8 */
> @@ -43,7 +43,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  	}
>  
>  	strbuf_addch(&out, '\n');
> -	trace_strbuf(trace_key, &out);
> +	trace_strbuf(&trace_packet, &out);
>  	strbuf_release(&out);
>  }
>  
> diff --git a/shallow.c b/shallow.c
> index 0b267b6..de07709 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -325,7 +325,7 @@ void prune_shallow(int show_only)
>  	strbuf_release(&sb);
>  }
>  
> -#define TRACE_KEY "GIT_TRACE_SHALLOW"
> +struct trace_key trace_shallow = TRACE_KEY_INIT(SHALLOW);
>  
>  /*
>   * Step 1, split sender shallow commits into "ours" and "theirs"
> @@ -334,7 +334,7 @@ void prune_shallow(int show_only)
>  void prepare_shallow_info(struct shallow_info *info, struct sha1_array *sa)
>  {
>  	int i;
> -	trace_printf_key(TRACE_KEY, "shallow: prepare_shallow_info\n");
> +	trace_printf_key(&trace_shallow, "shallow: prepare_shallow_info\n");
>  	memset(info, 0, sizeof(*info));
>  	info->shallow = sa;
>  	if (!sa)
> @@ -365,7 +365,7 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
>  {
>  	unsigned char (*sha1)[20] = info->shallow->sha1;
>  	int i, dst;
> -	trace_printf_key(TRACE_KEY, "shallow: remove_nonexistent_theirs_shallow\n");
> +	trace_printf_key(&trace_shallow, "shallow: remove_nonexistent_theirs_shallow\n");
>  	for (i = dst = 0; i < info->nr_theirs; i++) {
>  		if (i != dst)
>  			info->theirs[dst] = info->theirs[i];
> @@ -516,7 +516,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
>  	int *shallow, nr_shallow = 0;
>  	struct paint_info pi;
>  
> -	trace_printf_key(TRACE_KEY, "shallow: assign_shallow_commits_to_refs\n");
> +	trace_printf_key(&trace_shallow, "shallow: assign_shallow_commits_to_refs\n");
>  	shallow = xmalloc(sizeof(*shallow) * (info->nr_ours + info->nr_theirs));
>  	for (i = 0; i < info->nr_ours; i++)
>  		shallow[nr_shallow++] = info->ours[i];
> @@ -622,7 +622,7 @@ static void post_assign_shallow(struct shallow_info *info,
>  	int bitmap_nr = (info->ref->nr + 31) / 32;
>  	struct commit_array ca;
>  
> -	trace_printf_key(TRACE_KEY, "shallow: post_assign_shallow\n");
> +	trace_printf_key(&trace_shallow, "shallow: post_assign_shallow\n");
>  	if (ref_status)
>  		memset(ref_status, 0, sizeof(*ref_status) * info->ref->nr);
>  
> diff --git a/trace.c b/trace.c
> index 3e31558..8662b79 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -26,43 +26,66 @@
>  #include "quote.h"
>  
>  /* Get a trace file descriptor from "key" env variable. */
> -static int get_trace_fd(const char *key, int *need_close)
> +static int get_trace_fd(struct trace_key *key)
>  {
> -	char *trace = getenv(key);
> +	static struct trace_key trace_default = { "GIT_TRACE" };
> +	const char *trace;
> +
> +	/* use default "GIT_TRACE" if NULL */
> +	if (!key)
> +		key = &trace_default;
> +
> +	/* don't open twice */
> +	if (key->initialized)
> +		return key->fd;
> +
> +	trace = getenv(key->key);
>  
>  	if (!trace || !strcmp(trace, "") ||
>  	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
> -		return 0;
> -	if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
> -		return STDERR_FILENO;
> -	if (strlen(trace) == 1 && isdigit(*trace))
> -		return atoi(trace);
> -	if (is_absolute_path(trace)) {
> +		key->fd = 0;
> +	else if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
> +		key->fd = STDERR_FILENO;
> +	else if (strlen(trace) == 1 && isdigit(*trace))
> +		key->fd = atoi(trace);
> +	else if (is_absolute_path(trace)) {
>  		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
>  		if (fd == -1) {
>  			fprintf(stderr,
>  				"Could not open '%s' for tracing: %s\n"
>  				"Defaulting to tracing on stderr...\n",
>  				trace, strerror(errno));
> -			return STDERR_FILENO;
> +			key->fd = STDERR_FILENO;
> +		} else {
> +			key->fd = fd;
> +			key->need_close = 1;
>  		}
> -		*need_close = 1;
> -		return fd;
> +	} else {
> +		fprintf(stderr, "What does '%s' for %s mean?\n"
> +			"If you want to trace into a file, then please set "
> +			"%s to an absolute pathname (starting with /).\n"
> +			"Defaulting to tracing on stderr...\n",
> +			trace, key->key, key->key);
> +		key->fd = STDERR_FILENO;
>  	}
>  
> -	fprintf(stderr, "What does '%s' for %s mean?\n", trace, key);
> -	fprintf(stderr, "If you want to trace into a file, "
> -		"then please set %s to an absolute pathname "
> -		"(starting with /).\n", key);
> -	fprintf(stderr, "Defaulting to tracing on stderr...\n");
> +	key->initialized = 1;
> +	return key->fd;
> +}
>  
> -	return STDERR_FILENO;
> +void trace_disable(struct trace_key *key)
> +{
> +	if (key->need_close)
> +		close(key->fd);
> +	key->fd = 0;
> +	key->initialized = 1;
> +	key->need_close = 0;
>  }
>  
>  static const char err_msg[] = "Could not trace into fd given by "
>  	"GIT_TRACE environment variable";
>  
> -static void trace_vprintf(const char *key, const char *format, va_list ap)
> +static void trace_vprintf(struct trace_key *key, const char *format, va_list ap)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  
> @@ -75,7 +98,7 @@ static void trace_vprintf(const char *key, const char *format, va_list ap)
>  	strbuf_release(&buf);
>  }
>  
> -void trace_printf_key(const char *key, const char *format, ...)
> +void trace_printf_key(struct trace_key *key, const char *format, ...)
>  {
>  	va_list ap;
>  	va_start(ap, format);
> @@ -87,31 +110,24 @@ void trace_printf(const char *format, ...)
>  {
>  	va_list ap;
>  	va_start(ap, format);
> -	trace_vprintf("GIT_TRACE", format, ap);
> +	trace_vprintf(NULL, format, ap);
>  	va_end(ap);
>  }
>  
> -void trace_strbuf(const char *key, const struct strbuf *buf)
> +void trace_strbuf(struct trace_key *key, const struct strbuf *buf)
>  {
> -	int fd, need_close = 0;
> -
> -	fd = get_trace_fd(key, &need_close);
> +	int fd = get_trace_fd(key);
>  	if (!fd)
>  		return;
>  
>  	write_or_whine_pipe(fd, buf->buf, buf->len, err_msg);
> -
> -	if (need_close)
> -		close(fd);
>  }
>  
>  void trace_argv_printf(const char **argv, const char *format, ...)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	va_list ap;
> -	int fd, need_close = 0;
> -
> -	fd = get_trace_fd("GIT_TRACE", &need_close);
> +	int fd = get_trace_fd(NULL);
>  	if (!fd)
>  		return;
>  
> @@ -124,9 +140,6 @@ void trace_argv_printf(const char **argv, const char *format, ...)
>  	strbuf_addch(&buf, '\n');
>  	write_or_whine_pipe(fd, buf.buf, buf.len, err_msg);
>  	strbuf_release(&buf);
> -
> -	if (need_close)
> -		close(fd);
>  }
>  
>  static const char *quote_crnl(const char *path)
> @@ -155,11 +168,11 @@ static const char *quote_crnl(const char *path)
>  /* FIXME: move prefix to startup_info struct and get rid of this arg */
>  void trace_repo_setup(const char *prefix)
>  {
> -	static const char *key = "GIT_TRACE_SETUP";
> +	static struct trace_key key = TRACE_KEY_INIT(SETUP);
>  	const char *git_work_tree;
>  	char cwd[PATH_MAX];
>  
> -	if (!trace_want(key))
> +	if (!trace_want(&key))
>  		return;
>  
>  	if (!getcwd(cwd, PATH_MAX))
> @@ -171,18 +184,13 @@ void trace_repo_setup(const char *prefix)
>  	if (!prefix)
>  		prefix = "(null)";
>  
> -	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
> -	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
> -	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
> -	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));
> +	trace_printf_key(&key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
> +	trace_printf_key(&key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
> +	trace_printf_key(&key, "setup: cwd: %s\n", quote_crnl(cwd));
> +	trace_printf_key(&key, "setup: prefix: %s\n", quote_crnl(prefix));
>  }
>  
> -int trace_want(const char *key)
> +int trace_want(struct trace_key *key)
>  {
> -	const char *trace = getenv(key);
> -
> -	if (!trace || !strcmp(trace, "") ||
> -	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
> -		return 0;
> -	return 1;
> +	return !!get_trace_fd(key);
>  }
> diff --git a/trace.h b/trace.h
> index 8fea50b..fbfd9f4 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -4,14 +4,24 @@
>  #include "git-compat-util.h"
>  #include "strbuf.h"
>  
> +struct trace_key {
> +	const char const *key;
> +	int fd;
> +	char initialized : 1;
> +	char need_close : 1;
> +};
> +
> +#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name }
> +
>  __attribute__((format (printf, 1, 2)))
>  extern void trace_printf(const char *format, ...);
>  __attribute__((format (printf, 2, 3)))
>  extern void trace_argv_printf(const char **argv, const char *format, ...);
>  extern void trace_repo_setup(const char *prefix);
> -extern int trace_want(const char *key);
> +extern int trace_want(struct trace_key *key);
> +extern void trace_disable(struct trace_key *key);
>  __attribute__((format (printf, 2, 3)))
> -extern void trace_printf_key(const char *key, const char *format, ...);
> -extern void trace_strbuf(const char *key, const struct strbuf *buf);
> +extern void trace_printf_key(struct trace_key *key, const char *format, ...);
> +extern void trace_strbuf(struct trace_key *key, const struct strbuf *buf);
>  
>  #endif /* TRACE_H */
> -- 
> 2.0.0.406.ge74f8ff
>
> -- 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
