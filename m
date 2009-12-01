From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 4/8] Support remote helpers implementing smart
	transports
Date: Tue, 1 Dec 2009 11:22:33 -0800
Message-ID: <20091201192233.GL21299@spearce.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259675838-14692-5-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Dec 01 20:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFYJ9-0006x4-AD
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 20:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbZLATWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 14:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbZLATWc
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 14:22:32 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60535 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbZLATWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 14:22:31 -0500
Received: by ywh12 with SMTP id 12so5509475ywh.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 11:22:37 -0800 (PST)
Received: by 10.101.175.39 with SMTP id c39mr617883anp.87.1259695357578;
        Tue, 01 Dec 2009 11:22:37 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 4sm178821yxd.70.2009.12.01.11.22.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 11:22:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259675838-14692-5-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134251>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> index 5cfdc0c..adf815c 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -90,6 +90,28 @@ Supported if the helper has the "push" capability.
>  +
>  Supported if the helper has the "import" capability.
>  
> +'connect-r' <service>::
> +	Connects to given service. Stdin and stdout of helper are
> +	connected to specified service (no git or git- prefixes are used,
> +	so e.g. fetching uses 'upload-pack' as service) on remote side.

This flies against every other convention we have.  git:// uses the
string 'git-upload-pack' and 'git-receive-pack', and so does the
smart-http code.  We should continue to use the git- prefix here,
to be consistent, even though by context its clearly implied.

> +	Valid replies to this command are 'OK' (connection established),

Why 'OK'?  Currently remote-helpers return an empty blank line
to any successful command, not 'OK'.

> +	'FALLBACK' (no smart transport support, fall back to dumb
> +	transports) and 'ERROR' (can't connect, don't bother trying to
> +	fall back).

FALLBACK almost makes sense, but ERROR we don't do in the
the existing helper protocol.  Instead the helper simply
prints its error message(s) to stderr and does exit(128).
aka what die() does.

> +Supported if the helper has the "connect-r" capability. Not used if
> +helper has the "invoke-r" capability, as invoke is preferred to connect.
> +
> +'invoke-r' <cmdlength> <cmd>::
> +	Like connect-r command, but instead of service name, command
> +	line is given. The length of command field is given in command
> +	length field.
> ++
> +Supported if the helper has the "invoke-r" capability.

Why both connect-r and invoke-r?  Why isn't connect-r sufficient
here?  Isn't it sufficient for any service that runs over git:// ?

-- 
Shawn.
