From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Fri, 6 Jul 2007 13:38:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061320510.4093@racer.site>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
 <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
 <7vejjnhpap.fsf@assigned-by-dhcp.cox.net> <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
 <7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707051223520.9789@racer.site>
 <7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 14:46:38 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6nCl-0002Us-6D
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 14:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763256AbXGFMpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 08:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763265AbXGFMpx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 08:45:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:38901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763264AbXGFMpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 08:45:51 -0400
Received: (qmail invoked by alias); 06 Jul 2007 12:45:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 06 Jul 2007 14:45:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TgQc8QJnTjZbeVC5Xux7bCWenD3Kuy10NAiztlK
	LQ1GB1SC4YQzcr
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51747>

Hi,

On Fri, 6 Jul 2007, Junio C Hamano wrote:

> diff --git a/diff.c b/diff.c
> @@ -1143,6 +1154,82 @@ int diff_filespec_is_binary(struct diff_filespec *one)
>  	return one->is_binary;
>  }
>  
> +static struct hunk_header_regexp {
> +	char *name;
> +	char *regexp;
> +	struct hunk_header_regexp *next;
> +} *hunk_header_regexp_list, **hunk_header_regexp_tail;
> +
> +static int hunk_header_config(const char *var, const char *value)
> +{
> +	static const char funcname[] = "funcname.";
> +	struct hunk_header_regexp *hh;
> +
> +	if (prefixcmp(var, funcname))
> +		return 0;
> +	var += strlen(funcname);
> +	for (hh = hunk_header_regexp_list; hh; hh = hh->next)
> +		if (!strcmp(var, hh->name)) {
> +			free(hh->regexp);
> +			hh->regexp = xstrdup(value);
> +			return 0;
> +		}

Heh. By reordering your code, you could say

	if ((hh = hunk_header_regexp(var))) {
		free(hh->regexp);
		hh->regexp = xstrdup(value);
		return 0;
	}

> +	hh = xcalloc(1, sizeof(*hh));
> +	hh->name = xstrdup(var);
> +	hh->regexp = xstrdup(value);
> +	hh->next = NULL;
> +	*hunk_header_regexp_tail = hh;
> +	return 0;
> +}

Is that tail expansion not overly complex? Why not just set "hh->next = 
hunk_header_regexp_list; hunk_header_regexp_list = hh";

Yes, your code seems correct, but I took some extra cycles to get at that 
impression. A "static int parsed_config_for_hunk_headers" would have 
helped, instead of reusing _tail for two purposes. And this variable could 
be set at the beginning of hunk_header_config(), so that 
hunk_header_regexp() is usable from inside hunk_header_config().

> +static const char *hunk_header_regexp(const char *ident)
> +{
> +	struct hunk_header_regexp *hh;
> +
> +	if (!hunk_header_regexp_tail) {
> +		hunk_header_regexp_tail = &hunk_header_regexp_list;
> +		git_config(hunk_header_config);
> +	}
> +	for (hh = hunk_header_regexp_list; hh; hh = hh->next)
> +		if (!strcmp(ident, hh->name))
> +			return hh->regexp;
> +	return NULL;
> +}

Another thing. These long names are a bit inconsistent. In the config, you 
name it "funcname". In xdiff, we name them "FUNCNAMES". Yes, here they are 
hunk_headers.

Also, since the expressions are not strictly regular expressions, but 
lists of them, and with your idea they are even more different, why not 
just go for "funcname_list"? It's easier to read, and static anyway.

Rest looks fine to me...

Ciao,
Dscho
