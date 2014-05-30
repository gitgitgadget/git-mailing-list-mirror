From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: change read_ref_at to use the reflog iterators
Date: Fri, 30 May 2014 14:59:33 -0700
Message-ID: <xmqqfvjr6i7u.fsf@gitster.dls.corp.google.com>
References: <1401479462-2329-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:59:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqUq0-0003LW-58
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 23:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934776AbaE3V7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 17:59:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56940 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934761AbaE3V7i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 17:59:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4928F1B7DA;
	Fri, 30 May 2014 17:59:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VtKz9+D3Xo369AfJQboDJBdtTFU=; b=guEvsM
	qmiNkg39iQr4X0Z6Sq0ZXardKclIiNFBechpg3EVL6UTqkG2UME7toJGkpN1RLAv
	8TN4vowRbb8zLkQEaSCZgLxficA5fWI1WZYmfg3NtPv/NyV49Psa3D5W9ih9F175
	O5bMPFA9C9yUEYGF0rmH/7JXmwieHkScXYrOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TnDBCTHzBkzY6leZPwNvPy8XCllslXAM
	hVQLaQrbY3xOg5f8rBEZU69WpMCle3oijdEMlIEcdTmSjNrzBPymKdmYxtG88BGg
	dFkqDmMsWs7qZXBlop8eETrWrIY42cvFKjskUf/v9oXPeHY2CCIUrOWwjnHR0Kin
	IpDmT5mL5P4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FFF11B7D9;
	Fri, 30 May 2014 17:59:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9AA561B7C9;
	Fri, 30 May 2014 17:59:34 -0400 (EDT)
In-Reply-To: <1401479462-2329-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Fri, 30 May 2014 12:51:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AF8606BA-E845-11E3-A3B6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250492>

Ronnie Sahlberg <sahlberg@google.com> writes:

> read_ref_at has its own parsing of the reflog file for no really good reason
> so lets change this to use the existing reflog iterators. This removes one
> instance where we manually unmarshall the reflog file format.
>
> Log messages for errors are changed slightly. We no longer print the file
> name for the reflog, instead we refer to it as 'Log for ref <refname>'.
> This might be a minor useability regression, but I don't really think so, since
> experienced users would know where the log is anyway and inexperienced users
> would not know what to do about/how to repair 'Log ... has gap ...' anyway.
>
> Adapt the t1400 test to handle the cahnge in log messages.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c                | 217 ++++++++++++++++++++++++++++----------------------
>  t/t1400-update-ref.sh |   4 +-
>  2 files changed, 122 insertions(+), 99 deletions(-)

After reading the log message "we are removing one redundant
implementation", I would have expected that such a change would
remove a lot more lines than it would add.  Seeing the diffstat, I
have to wonder if the fact that we need more lines to reuse the API
is an indication that the reflog iterator API is overly cumbersome
to use, perhaps requiring too much boilerplate or something.

The update in the error message may be a side-effect, but I think it
is a change in the good direction.

Thanks.

> diff --git a/refs.c b/refs.c
> index 6898263..99d4832 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2936,109 +2936,132 @@ static char *ref_msg(const char *line, const char *endp)
>  	return xmemdupz(line, ep - line);
>  }
>  
> +struct read_ref_at_cb {
> +	const char *refname;
> +	unsigned long at_time;
> +	int cnt;
> +	int reccnt;
> +	unsigned char *sha1;
> +	int found_it;
> +
> +	char osha1[20];
> +	char nsha1[20];
> +	int tz;
> +	unsigned long date;
> +	char **msg;
> +	unsigned long *cutoff_time;
> +	int *cutoff_tz;
> +	int *cutoff_cnt;
> +};
> +
> +static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
> +		const char *email, unsigned long timestamp, int tz,
> +		const char *message, void *cb_data)
> +{
> +	struct read_ref_at_cb *cb = cb_data;
> +
> +	cb->reccnt++;
> +	cb->tz = tz;
> +	cb->date = timestamp;
> +
> +	if (timestamp <= cb->at_time || cb->cnt == 0) {
> +		if (cb->msg)
> +			*cb->msg = xstrdup(message);
> +		if (cb->cutoff_time)
> +			*cb->cutoff_time = timestamp;
> +		if (cb->cutoff_tz)
> +			*cb->cutoff_tz = tz;
> +		if (cb->cutoff_cnt)
> +			*cb->cutoff_cnt = cb->reccnt - 1;
> +
> +		/*
> +		 * we have not yet updated cb->[n|o]sha1 so they still
> +		 * hold the values for the previous record.
> +		 */
> +		if (!is_null_sha1(cb->osha1)) {
> +			hashcpy(cb->sha1, nsha1);
> +			if (hashcmp(cb->osha1, nsha1))
> +				warning("Log for ref %s has gap after %s.",
> +					cb->refname, show_date(cb->date, cb->tz, DATE_RFC2822));
> +		}
> +		else if (cb->date == cb->at_time)
> +			hashcpy(cb->sha1, nsha1);
> +		else
> +			if (hashcmp(nsha1, cb->sha1))
> +				warning("Log for ref %s unexpectedly ended on %s.",
> +					cb->refname, show_date(cb->date, cb->tz,
> +							   DATE_RFC2822));
> +
> +		/* 
> +		 * return 1. Not to signal an error but to break the loop
> +		 * since we have found the entry we want.
> +		 */
> +		hashcpy(cb->osha1, osha1);
> +		hashcpy(cb->nsha1, nsha1);
> +		cb->found_it = 1;
> +		return 1;
> +	}
> +
> +	hashcpy(cb->osha1, osha1);
> +	hashcpy(cb->nsha1, nsha1);
> +	if (cb->cnt > 0)
> +		cb->cnt--;
> +
> +	return 0;
> +}
> +
> +static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
> +				  const char *email, unsigned long timestamp,
> +				  int tz, const char *message, void *cb_data)
> +{
> +	struct read_ref_at_cb *cb = cb_data;
> +
> +	if (cb->msg)
> +		*cb->msg = xstrdup(message);
> +	if (cb->cutoff_time)
> +		*cb->cutoff_time = timestamp;
> +	if (cb->cutoff_tz)
> +		*cb->cutoff_tz = tz;
> +	if (cb->cutoff_cnt)
> +		*cb->cutoff_cnt = cb->reccnt - 1;
> +
> +	hashcpy(cb->sha1, osha1);
> +	if (is_null_sha1(cb->sha1))
> +		hashcpy(cb->sha1, nsha1);
> +
> +	/* 
> +	 * return 1. Not to signal an error but to break the loop
> +	 * since we have found the entry we want.
> +	 */
> +	return 1;
> +}
> +
>  int read_ref_at(const char *refname, unsigned long at_time, int cnt,
>  		unsigned char *sha1, char **msg,
>  		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
>  {
> -	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
> -	char *tz_c;
> -	int logfd, tz, reccnt = 0;
> -	struct stat st;
> -	unsigned long date;
> -	unsigned char logged_sha1[20];
> -	void *log_mapped;
> -	size_t mapsz;
> +	struct read_ref_at_cb cb;
>  
> -	logfile = git_path("logs/%s", refname);
> -	logfd = open(logfile, O_RDONLY, 0);
> -	if (logfd < 0)
> -		die_errno("Unable to read log '%s'", logfile);
> -	fstat(logfd, &st);
> -	if (!st.st_size)
> -		die("Log %s is empty.", logfile);
> -	mapsz = xsize_t(st.st_size);
> -	log_mapped = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, logfd, 0);
> -	logdata = log_mapped;
> -	close(logfd);
> +	memset(&cb, 0, sizeof(cb));
> +	cb.refname = refname;
> +	cb.at_time = at_time;
> +	cb.cnt = cnt;
> +	cb.msg = msg;
> +	cb.cutoff_time = cutoff_time;
> +	cb.cutoff_tz = cutoff_tz;
> +	cb.cutoff_cnt = cutoff_cnt;
> +	cb.sha1 = sha1;
> +
> +	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
> +
> +	if (!cb.reccnt)
> +		die("Log for %s is empty.", refname);
> +
> +	if (cb.found_it)
> +		return 0;
> +
> +	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
>  
> -	lastrec = NULL;
> -	rec = logend = logdata + st.st_size;
> -	while (logdata < rec) {
> -		reccnt++;
> -		if (logdata < rec && *(rec-1) == '\n')
> -			rec--;
> -		lastgt = NULL;
> -		while (logdata < rec && *(rec-1) != '\n') {
> -			rec--;
> -			if (*rec == '>')
> -				lastgt = rec;
> -		}
> -		if (!lastgt)
> -			die("Log %s is corrupt.", logfile);
> -		date = strtoul(lastgt + 1, &tz_c, 10);
> -		if (date <= at_time || cnt == 0) {
> -			tz = strtoul(tz_c, NULL, 10);
> -			if (msg)
> -				*msg = ref_msg(rec, logend);
> -			if (cutoff_time)
> -				*cutoff_time = date;
> -			if (cutoff_tz)
> -				*cutoff_tz = tz;
> -			if (cutoff_cnt)
> -				*cutoff_cnt = reccnt - 1;
> -			if (lastrec) {
> -				if (get_sha1_hex(lastrec, logged_sha1))
> -					die("Log %s is corrupt.", logfile);
> -				if (get_sha1_hex(rec + 41, sha1))
> -					die("Log %s is corrupt.", logfile);
> -				if (hashcmp(logged_sha1, sha1)) {
> -					warning("Log %s has gap after %s.",
> -						logfile, show_date(date, tz, DATE_RFC2822));
> -				}
> -			}
> -			else if (date == at_time) {
> -				if (get_sha1_hex(rec + 41, sha1))
> -					die("Log %s is corrupt.", logfile);
> -			}
> -			else {
> -				if (get_sha1_hex(rec + 41, logged_sha1))
> -					die("Log %s is corrupt.", logfile);
> -				if (hashcmp(logged_sha1, sha1)) {
> -					warning("Log %s unexpectedly ended on %s.",
> -						logfile, show_date(date, tz, DATE_RFC2822));
> -				}
> -			}
> -			munmap(log_mapped, mapsz);
> -			return 0;
> -		}
> -		lastrec = rec;
> -		if (cnt > 0)
> -			cnt--;
> -	}
> -
> -	rec = logdata;
> -	while (rec < logend && *rec != '>' && *rec != '\n')
> -		rec++;
> -	if (rec == logend || *rec == '\n')
> -		die("Log %s is corrupt.", logfile);
> -	date = strtoul(rec + 1, &tz_c, 10);
> -	tz = strtoul(tz_c, NULL, 10);
> -	if (get_sha1_hex(logdata, sha1))
> -		die("Log %s is corrupt.", logfile);
> -	if (is_null_sha1(sha1)) {
> -		if (get_sha1_hex(logdata + 41, sha1))
> -			die("Log %s is corrupt.", logfile);
> -	}
> -	if (msg)
> -		*msg = ref_msg(logdata, logend);
> -	munmap(log_mapped, mapsz);
> -
> -	if (cutoff_time)
> -		*cutoff_time = date;
> -	if (cutoff_tz)
> -		*cutoff_tz = tz;
> -	if (cutoff_cnt)
> -		*cutoff_cnt = reccnt;
>  	return 1;
>  }
>  
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 4e2459a..0218e96 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -235,7 +235,7 @@ test_expect_success \
>  	'rm -f o e &&
>  	 git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
>  	 test '"$B"' = $(cat o) &&
> -	 test "warning: Log .git/logs/'"$m has gap after $gd"'." = "$(cat e)"'
> +	 test "warning: Log for ref '"$m has gap after $gd"'." = "$(cat e)"'
>  test_expect_success \
>  	'Query "master@{2005-05-26 23:38:00}" (middle of history)' \
>  	'rm -f o e &&
> @@ -253,7 +253,7 @@ test_expect_success \
>  	'rm -f o e &&
>  	 git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
>  	 test '"$D"' = $(cat o) &&
> -	 test "warning: Log .git/logs/'"$m unexpectedly ended on $ld"'." = "$(cat e)"'
> +	 test "warning: Log for ref '"$m unexpectedly ended on $ld"'." = "$(cat e)"'
>  
>  
>  rm -f .git/$m .git/logs/$m expect
