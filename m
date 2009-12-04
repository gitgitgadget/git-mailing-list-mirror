From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 4/8] Support remote helpers implementing smart
	transports
Date: Fri, 4 Dec 2009 10:37:13 -0800
Message-ID: <20091204183713.GE1483@spearce.org>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259942168-24869-7-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGd1v-0007O0-QM
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbZLDShL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 13:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbZLDShL
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:37:11 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:60805 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbZLDShK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:37:10 -0500
Received: by gxk26 with SMTP id 26so2507308gxk.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 10:37:16 -0800 (PST)
Received: by 10.101.202.31 with SMTP id e31mr4454344anq.111.1259951836401;
        Fri, 04 Dec 2009 10:37:16 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm1642528yxg.46.2009.12.04.10.37.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 10:37:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259942168-24869-7-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134564>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
>  
> +'connect' <service>::
> +	Connects to given service. Stdin and stdout of helper are
> +	connected to specified service (git prefix is included in service
> +	name so e.g. fetching uses 'git-upload-pack' as service) on
> +	remote side. Valid replies to this command are empty line
> +	(connection established), 'FALLBACK' (no smart transport support,

Why not 'fallback' to remain consistent with this protocol and many
others in git where we stick to lowercase ASCII?

> +	fall back to dumb transports) and just exiting with error message
> +	printed (can't connect, don't bother trying to fall back). After
> +	line feed terminating the positive (empty) response, the output
> +	of service starts. After the connection ends, the remote
> +	helper exits. Note that to prevent deadlocking, all read data
> +	should be immediately flushed to outgoing connection (excepting
> +	remote initial advertisments, which should be flushed on first
> +	flush packet (0000 as length) encountered.

Why is the initial advertisement special?  If the helper always
flushes both sides, it shouldn't ever deadlock the protocol.  Also,
note that a helper should be able to implement a tiny delay like
Nagle's algorithm does in TCP.  It just can't sit on a byte forever.

> @@ -72,7 +73,10 @@ static struct child_process *get_helper(struct transport *transport)
>  	helper->argv = xcalloc(4, sizeof(*helper->argv));
>  	strbuf_addf(&buf, "remote-%s", data->name);
>  	helper->argv[0] = strbuf_detach(&buf, NULL);
> -	helper->argv[1] = transport->remote->name;
> +	if(transport->remote)
> +		helper->argv[1] = transport->remote->name;
> +	else
> +		helper->argv[1] = "";

This hunk appears to be unrelated.  And actually, if transport has
no remote, shouldn't the arg here be NULL so the helper gets only
1 argument and not 2 arguments?

> +static int _process_connect(struct transport *transport,
> +				      const char *name, const char *exec)
> +{
> +	struct helper_data *data = transport->data;
> +	struct strbuf cmdbuf = STRBUF_INIT;
> +	struct child_process *helper;
> +	int r;
> +
> +	helper = get_helper(transport);
> +
> +	/* Handle --upload-pack and friends. This is fire and forget...
> +	   just warn if it fails. */
> +	if(exec && strcmp(name, exec)) {
> +		r = set_helper_option(transport, "servpath", exec);
> +		if(r > 0)
> +			fprintf(stderr, "Warning: Setting remote service path "
> +				"not supported by protocol.\n");
> +		else if(r < 0)
> +			fprintf(stderr, "Warning: Invalid remote service "
> +				"path.\n");
> +	}

I think exec winds up defaulting to name if --upload-pack was not
used on the command line, and remote.$name.uploadpack was not set.
See transport.c where you initialize the git options struct, these
fields were defaulted in.

My point is, we shouldn't send option servpath to the helper if
name is equal to servpath, because the helper might not support
servpath and the option command will issue a warning above for no
reason at all.

-- 
Shawn.
