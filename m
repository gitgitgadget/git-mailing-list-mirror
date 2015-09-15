From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Tue, 15 Sep 2015 19:32:29 +0100
Message-ID: <55F8643D.6040800@ramsayjones.plus.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915153637.GO29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 20:32:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbv1s-0001y7-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 20:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbIOSc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 14:32:27 -0400
Received: from avasout08.plus.net ([212.159.14.20]:57478 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbbIOSc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 14:32:26 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout08 with smtp
	id HWYP1r0012FXpih01WYQmx; Tue, 15 Sep 2015 19:32:24 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=p6o69KaFkUE981UpIqUA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150915153637.GO29753@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277976>



On 15/09/15 16:36, Jeff King wrote:
> We sometimes sprintf into static buffers when we know that
> the size of the buffer is large enough to fit the input
> (either because it's a constant, or because it's numeric
> input that is bounded in size). Likewise with strcpy of
> constant strings.
>
> However, these sites make it hard to audit sprintf and
> strcpy calls for buffer overflows, as a reader has to
> cross-reference the size of the array with the input. Let's
> use xsnprintf instead, which communicates to a reader that
> we don't expect this to overflow (and catches the mistake in
> case we do).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> These are all pretty trivial; the obvious thing to get wrong is that
> "sizeof(buf)" is not the correct length if "buf" is a pointer. I
> considered a macro wrapper like:
>
>   #define xsnprintf_array(dst, fmt, ...) \
> 	xsnprintf(dst, sizeof(dst) + BARF_UNLESS_AN_ARRAY(dst), \
> 		  fmt, __VA_ARGS__)
>
> but obviously that requires variadic macro support.
>
>  archive-tar.c             |  2 +-
>  builtin/gc.c              |  2 +-
>  builtin/init-db.c         | 11 ++++++-----
>  builtin/ls-tree.c         |  9 +++++----
>  builtin/merge-index.c     |  2 +-
>  builtin/merge-recursive.c |  2 +-
>  builtin/read-tree.c       |  2 +-
>  builtin/unpack-file.c     |  2 +-
>  compat/mingw.c            |  8 +++++---
>  compat/winansi.c          |  2 +-
>  connect.c                 |  2 +-
>  convert.c                 |  3 ++-
>  daemon.c                  |  4 ++--
>  diff.c                    | 12 ++++++------
>  http-push.c               |  2 +-
>  http.c                    |  6 +++---
>  ll-merge.c                | 12 ++++++------
>  refs.c                    |  8 ++++----
>  sideband.c                |  4 ++--
>  strbuf.c                  |  4 ++--
>  20 files changed, 52 insertions(+), 47 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index b6b30bb..d543f93 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -301,7 +301,7 @@ static int write_global_extended_header(struct archiver_args *args)
>  	memset(&header, 0, sizeof(header));
>  	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
>  	mode = 0100666;
> -	strcpy(header.name, "pax_global_header");
> +	xsnprintf(header.name, sizeof(header.name), "pax_global_header");

How about using strlcpy() instead? Thus:

-	strcpy(header.name, "pax_global_header");
+	strlcpy(header.name, "pax_global_header", sizeof(header.name));

Ditto for other similar (strcpy->xsnprintf) hunks below.

ATB,
Ramsay Jones

>  	prepare_header(args, &header, mode, ext_header.len);
>  	write_blocked(&header, sizeof(header));
>  	write_blocked(ext_header.buf, ext_header.len);
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 0ad8d30..57584bc 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -194,7 +194,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  		return NULL;
>  
>  	if (gethostname(my_host, sizeof(my_host)))
> -		strcpy(my_host, "unknown");
> +		xsnprintf(my_host, sizeof(my_host), "unknown");
>  
>  	pidfile_path = git_pathdup("gc.pid");
>  	fd = hold_lock_file_for_update(&lock, pidfile_path,
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 69323e1..e7d0e31 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -262,7 +262,8 @@ static int create_default_files(const char *template_path)
>  	}
>  
>  	/* This forces creation of new config file */
> -	sprintf(repo_version_string, "%d", GIT_REPO_VERSION);
> +	xsnprintf(repo_version_string, sizeof(repo_version_string),
> +		  "%d", GIT_REPO_VERSION);
>  	git_config_set("core.repositoryformatversion", repo_version_string);
>  
>  	path[len] = 0;
> @@ -414,13 +415,13 @@ int init_db(const char *template_dir, unsigned int flags)
>  		 */
>  		if (shared_repository < 0)
>  			/* force to the mode value */
> -			sprintf(buf, "0%o", -shared_repository);
> +			xsnprintf(buf, sizeof(buf), "0%o", -shared_repository);
>  		else if (shared_repository == PERM_GROUP)
> -			sprintf(buf, "%d", OLD_PERM_GROUP);
> +			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
>  		else if (shared_repository == PERM_EVERYBODY)
> -			sprintf(buf, "%d", OLD_PERM_EVERYBODY);
> +			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
>  		else
> -			die("oops");
> +			die("BUG: invalid value for shared_repository");
>  		git_config_set("core.sharedrepository", buf);
>  		git_config_set("receive.denyNonFastforwards", "true");
>  	}
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 3b04a0f..0e30d86 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -96,12 +96,13 @@ static int show_tree(const unsigned char *sha1, struct strbuf *base,
>  			if (!strcmp(type, blob_type)) {
>  				unsigned long size;
>  				if (sha1_object_info(sha1, &size) == OBJ_BAD)
> -					strcpy(size_text, "BAD");
> +					xsnprintf(size_text, sizeof(size_text),
> +						  "BAD");
>  				else
> -					snprintf(size_text, sizeof(size_text),
> -						 "%lu", size);
> +					xsnprintf(size_text, sizeof(size_text),
> +						  "%lu", size);
>  			} else
> -				strcpy(size_text, "-");
> +				xsnprintf(size_text, sizeof(size_text), "-");
>  			printf("%06o %s %s %7s\t", mode, type,
>  			       find_unique_abbrev(sha1, abbrev),
>  			       size_text);
> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index 1a1eafa..1d66111 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -23,7 +23,7 @@ static int merge_entry(int pos, const char *path)
>  			break;
>  		found++;
>  		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
> -		sprintf(ownbuf[stage], "%o", ce->ce_mode);
> +		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
>  		arguments[stage] = hexbuf[stage];
>  		arguments[stage + 4] = ownbuf[stage];
>  	} while (++pos < active_nr);
> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> index a90f28f..491efd5 100644
> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -14,7 +14,7 @@ static const char *better_branch_name(const char *branch)
>  
>  	if (strlen(branch) != 40)
>  		return branch;
> -	sprintf(githead_env, "GITHEAD_%s", branch);
> +	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
>  	name = getenv(githead_env);
>  	return name ? name : branch;
>  }
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 2379e11..8c693e7 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -90,7 +90,7 @@ static int debug_merge(const struct cache_entry * const *stages,
>  	debug_stage("index", stages[0], o);
>  	for (i = 1; i <= o->merge_size; i++) {
>  		char buf[24];
> -		sprintf(buf, "ent#%d", i);
> +		xsnprintf(buf, sizeof(buf), "ent#%d", i);
>  		debug_stage(buf, stages[i], o);
>  	}
>  	return 0;
> diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
> index 1920029..6fc6bcd 100644
> --- a/builtin/unpack-file.c
> +++ b/builtin/unpack-file.c
> @@ -12,7 +12,7 @@ static char *create_temp_file(unsigned char *sha1)
>  	if (!buf || type != OBJ_BLOB)
>  		die("unable to read blob object %s", sha1_to_hex(sha1));
>  
> -	strcpy(path, ".merge_file_XXXXXX");
> +	xsnprintf(path, sizeof(path), ".merge_file_XXXXXX");
>  	fd = xmkstemp(path);
>  	if (write_in_full(fd, buf, size) != size)
>  		die_errno("unable to write temp-file");
> diff --git a/compat/mingw.c b/compat/mingw.c
> index f74da23..a168800 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2133,9 +2133,11 @@ int uname(struct utsname *buf)
>  {
>  	DWORD v = GetVersion();
>  	memset(buf, 0, sizeof(*buf));
> -	strcpy(buf->sysname, "Windows");
> -	sprintf(buf->release, "%u.%u", v & 0xff, (v >> 8) & 0xff);
> +	xsnprintf(buf->sysname, sizeof(buf->sysname), "Windows");
> +	xsnprintf(buf->release, sizeof(buf->release),
> +		 "%u.%u", v & 0xff, (v >> 8) & 0xff);
>  	/* assuming NT variants only.. */
> -	sprintf(buf->version, "%u", (v >> 16) & 0x7fff);
> +	xsnprintf(buf->version, sizeof(buf->version),
> +		  "%u", (v >> 16) & 0x7fff);
>  	return 0;
>  }
> diff --git a/compat/winansi.c b/compat/winansi.c
> index efc5bb3..ceff55b 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -539,7 +539,7 @@ void winansi_init(void)
>  		return;
>  
>  	/* create a named pipe to communicate with the console thread */
> -	sprintf(name, "\\\\.\\pipe\\winansi%lu", GetCurrentProcessId());
> +	xsnprintf(name, sizeof(name), "\\\\.\\pipe\\winansi%lu", GetCurrentProcessId());
>  	hwrite = CreateNamedPipe(name, PIPE_ACCESS_OUTBOUND,
>  		PIPE_TYPE_BYTE | PIPE_WAIT, 1, BUFFER_SIZE, 0, 0, NULL);
>  	if (hwrite == INVALID_HANDLE_VALUE)
> diff --git a/connect.c b/connect.c
> index c0144d8..1d5c5e0 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -332,7 +332,7 @@ static const char *ai_name(const struct addrinfo *ai)
>  	static char addr[NI_MAXHOST];
>  	if (getnameinfo(ai->ai_addr, ai->ai_addrlen, addr, sizeof(addr), NULL, 0,
>  			NI_NUMERICHOST) != 0)
> -		strcpy(addr, "(unknown)");
> +		xsnprintf(addr, sizeof(addr), "(unknown)");
>  
>  	return addr;
>  }
> diff --git a/convert.c b/convert.c
> index f3bd3e9..814e814 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1289,7 +1289,8 @@ static struct stream_filter *ident_filter(const unsigned char *sha1)
>  {
>  	struct ident_filter *ident = xmalloc(sizeof(*ident));
>  
> -	sprintf(ident->ident, ": %s $", sha1_to_hex(sha1));
> +	xsnprintf(ident->ident, sizeof(ident->ident),
> +		  ": %s $", sha1_to_hex(sha1));
>  	strbuf_init(&ident->left, 0);
>  	ident->filter.vtbl = &ident_vtbl;
>  	ident->state = 0;
> diff --git a/daemon.c b/daemon.c
> index f9eb296..5218a3f 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -901,7 +901,7 @@ static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
>  		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, len);
>  		break;
>  	default:
> -		strcpy(ip, "<unknown>");
> +		xsnprintf(ip, sizeof(ip), "<unknown>");
>  	}
>  	return ip;
>  }
> @@ -916,7 +916,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
>  	int gai;
>  	long flags;
>  
> -	sprintf(pbuf, "%d", listen_port);
> +	xsnprintf(pbuf, sizeof(pbuf), "%d", listen_port);
>  	memset(&hints, 0, sizeof(hints));
>  	hints.ai_family = AF_UNSPEC;
>  	hints.ai_socktype = SOCK_STREAM;
> diff --git a/diff.c b/diff.c
> index 08508f6..788e371 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2880,7 +2880,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
>  	temp->name = get_tempfile_path(&temp->tempfile);
>  	strcpy(temp->hex, sha1_to_hex(sha1));
>  	temp->hex[40] = 0;
> -	sprintf(temp->mode, "%06o", mode);
> +	xsnprintf(temp->mode, sizeof(temp->mode), "%06o", mode);
>  	strbuf_release(&buf);
>  	strbuf_release(&template);
>  	free(path_dup);
> @@ -2897,8 +2897,8 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
>  		 * a '+' entry produces this for file-1.
>  		 */
>  		temp->name = "/dev/null";
> -		strcpy(temp->hex, ".");
> -		strcpy(temp->mode, ".");
> +		xsnprintf(temp->hex, sizeof(temp->hex), ".");
> +		xsnprintf(temp->mode, sizeof(temp->mode), ".");
>  		return temp;
>  	}
>  
> @@ -2935,7 +2935,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
>  			 * !(one->sha1_valid), as long as
>  			 * DIFF_FILE_VALID(one).
>  			 */
> -			sprintf(temp->mode, "%06o", one->mode);
> +			xsnprintf(temp->mode, sizeof(temp->mode), "%06o", one->mode);
>  		}
>  		return temp;
>  	}
> @@ -4081,9 +4081,9 @@ const char *diff_unique_abbrev(const unsigned char *sha1, int len)
>  	if (abblen < 37) {
>  		static char hex[41];
>  		if (len < abblen && abblen <= len + 2)
> -			sprintf(hex, "%s%.*s", abbrev, len+3-abblen, "..");
> +			xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
>  		else
> -			sprintf(hex, "%s...", abbrev);
> +			xsnprintf(hex, sizeof(hex), "%s...", abbrev);
>  		return hex;
>  	}
>  	return sha1_to_hex(sha1);
> diff --git a/http-push.c b/http-push.c
> index c98dad2..154e67b 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -881,7 +881,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
>  	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, escaped);
>  	free(escaped);
>  
> -	sprintf(timeout_header, "Timeout: Second-%ld", timeout);
> +	xsnprintf(timeout_header, sizeof(timeout_header), "Timeout: Second-%ld", timeout);
>  	dav_headers = curl_slist_append(dav_headers, timeout_header);
>  	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
>  
> diff --git a/http.c b/http.c
> index 9dce380..7b02259 100644
> --- a/http.c
> +++ b/http.c
> @@ -1104,7 +1104,7 @@ static void write_accept_language(struct strbuf *buf)
>  		     decimal_places++, max_q *= 10)
>  			;
>  
> -		sprintf(q_format, ";q=0.%%0%dd", decimal_places);
> +		xsnprintf(q_format, sizeof(q_format), ";q=0.%%0%dd", decimal_places);
>  
>  		strbuf_addstr(buf, "Accept-Language: ");
>  
> @@ -1601,7 +1601,7 @@ struct http_pack_request *new_http_pack_request(
>  			fprintf(stderr,
>  				"Resuming fetch of pack %s at byte %ld\n",
>  				sha1_to_hex(target->sha1), prev_posn);
> -		sprintf(range, "Range: bytes=%ld-", prev_posn);
> +		xsnprintf(range, sizeof(range), "Range: bytes=%ld-", prev_posn);
>  		preq->range_header = curl_slist_append(NULL, range);
>  		curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
>  			preq->range_header);
> @@ -1761,7 +1761,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
>  			fprintf(stderr,
>  				"Resuming fetch of object %s at byte %ld\n",
>  				hex, prev_posn);
> -		sprintf(range, "Range: bytes=%ld-", prev_posn);
> +		xsnprintf(range, sizeof(range), "Range: bytes=%ld-", prev_posn);
>  		range_header = curl_slist_append(range_header, range);
>  		curl_easy_setopt(freq->slot->curl,
>  				 CURLOPT_HTTPHEADER, range_header);
> diff --git a/ll-merge.c b/ll-merge.c
> index fc3c049..56f73b3 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -142,11 +142,11 @@ static struct ll_merge_driver ll_merge_drv[] = {
>  	{ "union", "built-in union merge", ll_union_merge },
>  };
>  
> -static void create_temp(mmfile_t *src, char *path)
> +static void create_temp(mmfile_t *src, char *path, size_t len)
>  {
>  	int fd;
>  
> -	strcpy(path, ".merge_file_XXXXXX");
> +	xsnprintf(path, len, ".merge_file_XXXXXX");
>  	fd = xmkstemp(path);
>  	if (write_in_full(fd, src->ptr, src->size) != src->size)
>  		die_errno("unable to write temp-file");
> @@ -187,10 +187,10 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
>  
>  	result->ptr = NULL;
>  	result->size = 0;
> -	create_temp(orig, temp[0]);
> -	create_temp(src1, temp[1]);
> -	create_temp(src2, temp[2]);
> -	sprintf(temp[3], "%d", marker_size);
> +	create_temp(orig, temp[0], sizeof(temp[0]));
> +	create_temp(src1, temp[1], sizeof(temp[1]));
> +	create_temp(src2, temp[2], sizeof(temp[2]));
> +	xsnprintf(temp[3], sizeof(temp[3]), "%d", marker_size);
>  
>  	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);
>  
> diff --git a/refs.c b/refs.c
> index 4e15f60..d5c8b2f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3326,10 +3326,10 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
>  	msglen = msg ? strlen(msg) : 0;
>  	maxlen = strlen(committer) + msglen + 100;
>  	logrec = xmalloc(maxlen);
> -	len = sprintf(logrec, "%s %s %s\n",
> -		      sha1_to_hex(old_sha1),
> -		      sha1_to_hex(new_sha1),
> -		      committer);
> +	len = xsnprintf(logrec, maxlen, "%s %s %s\n",
> +			sha1_to_hex(old_sha1),
> +			sha1_to_hex(new_sha1),
> +			committer);
>  	if (msglen)
>  		len += copy_msg(logrec + len - 1, msg) - 1;
>  
> diff --git a/sideband.c b/sideband.c
> index 7f9dc22..fde8adc 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -137,11 +137,11 @@ ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet
>  		if (packet_max - 5 < n)
>  			n = packet_max - 5;
>  		if (0 <= band) {
> -			sprintf(hdr, "%04x", n + 5);
> +			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
>  			hdr[4] = band;
>  			write_or_die(fd, hdr, 5);
>  		} else {
> -			sprintf(hdr, "%04x", n + 4);
> +			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
>  			write_or_die(fd, hdr, 4);
>  		}
>  		write_or_die(fd, p, n);
> diff --git a/strbuf.c b/strbuf.c
> index 6c1b577..46a3d20 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -245,8 +245,8 @@ void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size
>  	static char prefix2[2];
>  
>  	if (prefix1[0] != comment_line_char) {
> -		sprintf(prefix1, "%c ", comment_line_char);
> -		sprintf(prefix2, "%c", comment_line_char);
> +		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
> +		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
>  	}
>  	add_lines(out, prefix1, prefix2, buf, size);
>  }
