From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Thu, 04 Sep 2014 10:25:43 -0700
Message-ID: <xmqqa96fuwko.fsf@gitster.dls.corp.google.com>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
	<CACsJy8C_=aNX9LT2V_zhw++tC22C5SDfwbpTS=juONMxwcV9pA@mail.gmail.com>
	<xmqqtx4nuy5k.fsf@gitster.dls.corp.google.com>
	<xmqqmwafux3y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 19:26:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPanU-0004KX-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 19:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbaIDRZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 13:25:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52344 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351AbaIDRZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 13:25:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D80D37FBA;
	Thu,  4 Sep 2014 13:25:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XDYUBocva/yVHup3yY9pz7P+65E=; b=vvJxMp
	fAYKvdjqSANoFZMbANXOzSJAK7ZYpQhALJ2uu/2NhxaCd/rxLs2Ct5UeLqgwvvhf
	kw29alx+qwg5HUEVS9i1bvgqKPqtYDhaIYMl+3fb1p6pbkWhN32IZ1PjVcNnEthu
	BRN8h0Ig+deSy5AoPCkA9RFo96AQ+eYf+6rus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uCIc2dV/caCKwo3RCUBTvNtO4JAjfHVM
	O+6LHUjAxE22xiag9AyoQu1fmkRK7qEy7EZI/BPUivbCiLA3iRecNZfxuNjJ8LW9
	Q7tKgHwWUqptQDej7KbZ2hXolaks7MQ8V58jwxM2ubr9T2xnJHlvkSCS1HjM3KjD
	MO36nN3iY5I=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4384237FB9;
	Thu,  4 Sep 2014 13:25:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9360437FB8;
	Thu,  4 Sep 2014 13:25:44 -0400 (EDT)
In-Reply-To: <xmqqmwafux3y.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 04 Sep 2014 10:14:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 808870C8-3458-11E4-87AC-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256454>

Junio C Hamano <gitster@pobox.com> writes:

> You can see the interactions by checking
>
>     $ git show 'pu^{/^Merge branch .nd/multi}' refs.c

Here is how it may look like.

    Merge branch 'nd/multiple-work-trees' into pu

diff --cc refs.c
index b50b329,00b2312..f04d934
--- a/refs.c
+++ b/refs.c
@@@ -1359,34 -1533,33 +1359,38 @@@ static const char *handle_missing_loose
  	}
  }
  
 -const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
 +/* This function needs to return a meaningful errno on failure */
 +const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
  {
+ 	struct strbuf sb_path = STRBUF_INIT;
  	int depth = MAXDEPTH;
  	ssize_t len;
  	char buffer[256];
  	static char refname_buffer[256];
+ 	const char *ret;
  
 -	if (flag)
 -		*flag = 0;
 +	if (ref_flag)
 +		*ref_flag = 0;
  
 -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 +	if (!(flags & RESOLVE_REF_ALLOW_BAD_NAME) &&
 +	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 +		errno = EINVAL;
  		return NULL;
 -
 +	}
  	for (;;) {
- 		char path[PATH_MAX];
+ 		const char *path;
  		struct stat st;
  		char *buf;
  		int fd;
  
 -		if (--depth < 0)
 +		if (--depth < 0) {
 +			errno = ELOOP;
- 			return NULL;
+ 			goto fail;
 +		}
  
- 		git_snpath(path, sizeof(path), "%s", refname);
+ 		strbuf_reset(&sb_path);
+ 		strbuf_git_path(&sb_path, "%s", refname);
+ 		path = sb_path.buf;
  
  		/*
  		 * We might have to loop back here to avoid a race
@@@ -1400,11 -1573,11 +1404,12 @@@
  	stat_ref:
  		if (lstat(path, &st) < 0) {
  			if (errno == ENOENT)
- 				return handle_missing_loose_ref(refname, sha1,
+ 				ret = handle_missing_loose_ref(refname, sha1,
 -							       reading, flag);
 +						flags & RESOLVE_REF_READING,
 +						ref_flag);
  			else
- 				return NULL;
+ 				ret = NULL;
+ 			goto done;
  		}
  
  		/* Follow "normalized" - ie "refs/.." symlinks by hand */
@@@ -1444,16 -1617,13 +1449,17 @@@
  				/* inconsistent with lstat; retry */
  				goto stat_ref;
  			else
- 				return NULL;
+ 				goto fail;
  		}
+ 
  		len = read_in_full(fd, buffer, sizeof(buffer)-1);
 -		close(fd);
 -		if (len < 0)
 +		if (len < 0) {
 +			int save_errno = errno;
 +			close(fd);
 +			errno = save_errno;
- 			return NULL;
+ 			goto fail;
 +		}
 +		close(fd);
  		while (len && isspace(buffer[len-1]))
  			len--;
  		buffer[len] = '\0';
@@@ -1468,31 -1638,35 +1474,37 @@@
  			 */
  			if (get_sha1_hex(buffer, sha1) ||
  			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
 -				if (flag)
 -					*flag |= REF_ISBROKEN;
 +				if (ref_flag)
 +					*ref_flag |= REF_ISBROKEN;
 +				errno = EINVAL;
- 				return NULL;
+ 				goto fail;
  			}
- 			return refname;
+ 			ret = refname;
+ 			goto done;
  		}
 -		if (flag)
 -			*flag |= REF_ISSYMREF;
 +		if (ref_flag)
 +			*ref_flag |= REF_ISSYMREF;
  		buf = buffer + 4;
  		while (isspace(*buf))
  			buf++;
  		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 -			if (flag)
 -				*flag |= REF_ISBROKEN;
 +			if (ref_flag)
 +				*ref_flag |= REF_ISBROKEN;
 +			errno = EINVAL;
- 			return NULL;
+ 			goto fail;
  		}
  		refname = strcpy(refname_buffer, buf);
  	}
+ fail:
+ 	ret = NULL;
+ done:
+ 	strbuf_release(&sb_path);
+ 	return ret;
  }
  
 -char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag)
 +char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag)
  {
 -	const char *ret = resolve_ref_unsafe(ref, sha1, reading, flag);
 +	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
  	return ret ? xstrdup(ret) : NULL;
  }
  
@@@ -2106,16 -2263,11 +2118,16 @@@ int dwim_log(const char *str, int len, 
  	return logs_found;
  }
  
 +/*
 + * Locks a "refs/" ref returning the lock on success and NULL on failure.
 + * On failure errno is set to something meaningful.
 + */
  static struct ref_lock *lock_ref_sha1_basic(const char *refname,
  					    const unsigned char *old_sha1,
 -					    int flags, int *type_p)
 +					    int flags, int *type_p,
 +					    const char **skip, int skipnum)
  {
- 	char *ref_file;
+ 	const char *ref_file;
  	const char *orig_refname = refname;
  	struct ref_lock *lock;
  	int last_errno = 0;
@@@ -2750,52 -2952,41 +2762,57 @@@ static int copy_msg(char *buf, const ch
  	return cp - buf;
  }
  
 -int log_ref_setup(const char *refname, struct strbuf *logfile)
 +/* This function must set a meaningful errno on failure */
 +int create_reflog(const char *refname)
  {
  	int logfd, oflags = O_APPEND | O_WRONLY;
- 	char logfile[PATH_MAX];
- 
- 	git_snpath(logfile, sizeof(logfile), "logs/%s", refname);
- 	if (starts_with(refname, "refs/heads/") ||
- 	    starts_with(refname, "refs/remotes/") ||
- 	    starts_with(refname, "refs/notes/") ||
- 	    !strcmp(refname, "HEAD")) {
- 		if (safe_create_leading_directories(logfile) < 0) {
++	struct strbuf logfile = STRBUF_INIT;
+ 
 -	strbuf_git_path(logfile, "logs/%s", refname);
++	strbuf_git_path(&logfile, "logs/%s", refname);
+ 	if (log_all_ref_updates &&
+ 	    (starts_with(refname, "refs/heads/") ||
+ 	     starts_with(refname, "refs/remotes/") ||
+ 	     starts_with(refname, "refs/notes/") ||
+ 	     !strcmp(refname, "HEAD"))) {
 -		if (safe_create_leading_directories(logfile->buf) < 0)
 -			return error("unable to create directory for %s",
 -				     logfile->buf);
++		if (safe_create_leading_directories(logfile.buf) < 0) {
 +			int save_errno = errno;
- 			error("unable to create directory for %s", logfile);
++			error("unable to create directory for %s", logfile.buf);
++			strbuf_release(&logfile);
 +			errno = save_errno;
 +			return -1;
 +		}
  		oflags |= O_CREAT;
  	}
  
- 	logfd = open(logfile, oflags, 0666);
 -	logfd = open(logfile->buf, oflags, 0666);
++	logfd = open(logfile.buf, oflags, 0666);
  	if (logfd < 0) {
  		if (!(oflags & O_CREAT) && errno == ENOENT)
  			return 0;
  
  		if ((oflags & O_CREAT) && errno == EISDIR) {
- 			if (remove_empty_directories(logfile)) {
 -			if (remove_empty_directories(logfile->buf)) {
 -				return error("There are still logs under '%s'",
 -					     logfile->buf);
++			if (remove_empty_directories(logfile.buf)) {
 +				int save_errno = errno;
 +				error("There are still logs under '%s'",
- 				      logfile);
++				      logfile.buf);
++				strbuf_release(&logfile);
 +				errno = save_errno;
 +				return -1;
  			}
- 			logfd = open(logfile, oflags, 0666);
 -			logfd = open(logfile->buf, oflags, 0666);
++			logfd = open(logfile.buf, oflags, 0666);
  		}
  
 -		if (logfd < 0)
 -			return error("Unable to append to %s: %s",
 -				     logfile->buf, strerror(errno));
 +		if (logfd < 0) {
 +			int save_errno = errno;
- 			error("Unable to append to %s: %s", logfile,
++			error("Unable to append to %s: %s", logfile.buf,
 +			      strerror(errno));
++			strbuf_release(&logfile);
 +			errno = save_errno;
 +			return -1;
 +		}
  	}
  
- 	adjust_shared_perm(logfile);
 -	adjust_shared_perm(logfile->buf);
++	adjust_shared_perm(logfile.buf);
++	strbuf_release(&logfile);
  	close(logfd);
  	return 0;
  }
@@@ -2817,54 -3023,18 +2834,58 @@@ static int log_ref_write_fd(int fd, con
  		      committer);
  	if (msglen)
  		len += copy_msg(logrec + len - 1, msg) - 1;
 -	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 +
 +	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
  	free(logrec);
 -	if (close(logfd) != 0 || written != len) {
 -		error("Unable to append to %s", log_file);
 -		result = -1;
 -	}
 -done:
 -	strbuf_release(&sb_log_file);
 -	return result;
 +	if (written != len)
 +		return -1;
 +
 +	return 0;
 +}
 +
 +static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 +			 const unsigned char *new_sha1, const char *msg)
 +{
 +	int logfd, result = 0, oflags = O_APPEND | O_WRONLY;
- 	char log_file[PATH_MAX];
++	struct strbuf logfile = STRBUF_INIT;
++	int status = 0;
 +
 +	if (log_all_ref_updates < 0)
 +		log_all_ref_updates = !is_bare_repository();
 +
 +	if (log_all_ref_updates && !reflog_exists(refname))
 +		result = create_reflog(refname);
 +
 +	if (result)
 +		return result;
 +
- 	git_snpath(log_file, sizeof(log_file), "logs/%s", refname);
++	strbuf_git_path(&logfile, "logs/%s", refname);
 +
- 	logfd = open(log_file, oflags);
++	logfd = open(logfile.buf, oflags);
 +	if (logfd < 0)
- 		return 0;
++		goto fini;
 +	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 +				  git_committer_info(0), msg);
 +	if (result) {
 +		int save_errno = errno;
 +		close(logfd);
- 		error("Unable to append to %s", log_file);
++		error("Unable to append to %s", logfile.buf);
 +		errno = save_errno;
- 		return -1;
++		status = -1;
++		goto fini;
 +	}
 +	if (close(logfd)) {
 +		int save_errno = errno;
- 		error("Unable to append to %s", log_file);
++		error("Unable to append to %s", logfile.buf);
 +		errno = save_errno;
- 		return -1;
++		status = -1;
 +	}
- 	return 0;
++fini:
++	strbuf_release(&logfile);
++	return status;
  }
  
 -static int is_branch(const char *refname)
 +int is_branch(const char *refname)
  {
  	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
  }
