From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7 v2] Compute prefix at runtime if RUNTIME_PREFIX is
 set
Date: Mon, 19 Jan 2009 18:41:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901191825040.3586@pacific.mpi-cbg.de>
References: <1232280015-8144-1-git-send-email-prohaska@zib.de> <1232280015-8144-2-git-send-email-prohaska@zib.de> <1232280015-8144-3-git-send-email-prohaska@zib.de> <1232280015-8144-4-git-send-email-prohaska@zib.de> <1232280015-8144-5-git-send-email-prohaska@zib.de>
 <1232280015-8144-6-git-send-email-prohaska@zib.de> <1232280015-8144-7-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 18:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOy92-0007IM-IS
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbZASRlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbZASRlP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:41:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:41789 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751753AbZASRlO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 12:41:14 -0500
Received: (qmail invoked by alias); 19 Jan 2009 17:41:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 19 Jan 2009 18:41:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qCFFfo7NquExf0ITlMW+nJZm0KVGn7ik1gNMKNM
	u3xxBGtDtsV/nr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232280015-8144-7-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106372>

Hi,

On Sun, 18 Jan 2009, Steffen Prohaska wrote:

> +	if (!prefix) {
> +		const char *strip[] = {
> +			GIT_EXEC_PATH,
> +			BINDIR,
> +			0
> +		};
> +		const char **s;
> +
> +		for (s = strip; *s; s++) {
> +			const char *sargv = argv0_path + strlen(argv0_path);

This does not need to be recomputed all the time, right?

> +			const char *ss = *s + strlen(*s);
> +			while (argv0_path < sargv && *s < ss
> +				&& (*sargv == *ss ||
> +				    (is_dir_sep(*sargv) && is_dir_sep(*ss)))) {
> +				sargv--;
> +				ss--;
> +			}
> +			if (*s == ss) {
> +				struct strbuf d = STRBUF_INIT;
> +				/* We also skip the trailing directory separator. */
> +				assert(sargv - argv0_path - 1 >= 0);
> +				strbuf_add(&d, argv0_path, sargv - argv0_path - 1);
> +				prefix = strbuf_detach(&d, NULL);
> +				break;
> +			}
> +		}
> +	}

I have a definite feeling that this code would be easier to read if it 
resembled this:

/* sets prefix if the suffix matches (modulo separator changes) */
static int strip_path_suffix(const char *path, const char *suffix,
	char **prefix)
{
	int path_len = strlen(path), suffix_len = strlen(suffix);

	while (suffix_len) {
		if (!path_len)
			return 1;

		path_len--; suffix_len--;
		/* strip arbitrary amount of directory separators */
		if (is_dir_sep(path[path_len]) && 
				is_dir_sep(suffix[suffix_len])) {
			while (path_len && is_dir_sep(path[path_len]))
				path_len--;
			while (suffix_len && is_dir_sep(suffix[suffix_len]))
				suffix_len--;
		}
		else if (path[path_len] != suffix[suffix_len])
			return 1;
	}

	while (path_len && is_dir_sep(path[path_len - 1]))
		path_len--;

	prefix = xstrndup(path, path_len);
	return 0;
}

...

	if (!prefix && strip_path_suffix(argv0_path, GIT_EXEC_PATH) &&
			strip_path_suffix(argv0_path, BINDIR)) {
		prefix = PREFIX;
		...

Note: this function could be exported in path.c, as it also handles the 
"a//bin" vs "a/bin" case.

Ciao,
Dscho
