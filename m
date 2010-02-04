From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
	count in bytes
Date: Thu, 4 Feb 2010 09:24:21 -0800
Message-ID: <20100204172421.GA18548@spearce.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net> <1265255308-20514-3-git-send-email-nico@fluxnic.net> <20100204040046.GR14799@spearce.org> <7v7hqtty38.fsf@alter.siamese.dyndns.org> <7vtytxexjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:25:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5S2-0002OD-Nr
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933273Ab0BDRYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:24:32 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:57376 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933151Ab0BDRYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:24:30 -0500
Received: by iwn27 with SMTP id 27so1847280iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 09:24:29 -0800 (PST)
Received: by 10.231.146.66 with SMTP id g2mr326256ibv.88.1265304266339;
        Thu, 04 Feb 2010 09:24:26 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm253288iwn.2.2010.02.04.09.24.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 09:24:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtytxexjl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138985>

Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] fast-import: count --max-pack-size in bytes
>  	if (!prefixcmp(option, "max-pack-size=")) {
> -		option_max_pack_size(option + 14);
> +		unsigned long v;
> +		if (!git_parse_ulong(option + 14, &v))
> +			return 0;
> +		if (v < 1024 * 1024) {
> +			warning("minimum max-pack-size is 1 MiB");
> +			v = 1024 * 1024;
> +		}
> +		max_packsize = v;

How about for a transition period we do:

  if (v < 8192) {
  	warning("max-pack-size is now in bytes, assuming %dm", v);
	v *= 1024 * 1024;
  }

So that existing users won't be completely broken if they are
relying on this flag, and have some time to adjust.

Given the huge magnitude between the old sane value range, and the
new sane value range, we can safely assume anything below a small
number like 8192 is an old user, warn them, and assume old behavior.

A local pack smaller than 1 MiB is mostly pointless coming out of
a tool like git repack or git fast-import, unless its a complete
copy of the repository.  So the old style calling convention of
4096 for 4 GiB would now imply a pack so small, we probably can't
get more than 1 object per pack.

-- 
Shawn.
