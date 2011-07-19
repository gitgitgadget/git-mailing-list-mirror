From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard
 file
Date: Tue, 19 Jul 2011 15:35:41 -0500
Message-ID: <20110719203541.GB26557@elie.gateway.2wire.net>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <1311095876-3098-3-git-send-email-artagnon@gmail.com>
 <20110719195504.GA3957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 19 22:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjH1G-0005rn-Lj
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 22:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab1GSUfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 16:35:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44500 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1GSUfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 16:35:48 -0400
Received: by ywe9 with SMTP id 9so1958986ywe.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gePrbCdu0rxJDFAwYhGDn2wc+9jyOo4aH+7YB3UtY74=;
        b=JMSvz87wwqrmHeERMWsf29Ucr9O4NCtsPBGeW/7zfLRCskhFjddxyOXITE5xLpGVcc
         5evYz8IDR+3zcQn8q0FE1fZtIDi+M/h/U7nhuCxWf3gpyane2VzSesiblPllrMYoSIHu
         7nQ3L8H5ewxSjbrIOOe3ZP1z3LR0mQx6N/eMY=
Received: by 10.236.179.34 with SMTP id g22mr4368074yhm.327.1311107747316;
        Tue, 19 Jul 2011 13:35:47 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-74-225.dsl.chcgil.ameritech.net [69.209.74.225])
        by mx.google.com with ESMTPS id c69sm179583yhm.29.2011.07.19.13.35.43
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 13:35:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110719195504.GA3957@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177503>

Jeff King wrote:

> BTW, I'm unclear why we bother duplicating the filename in the first
> place. It seems like we could go even simpler with:
>
> int git_config_set_multivar(const char *key, const char *value,
>                             const char *value_regex, int multi_replace)
> {
> 	char *config_filename;
>
> 	if (config_exclusive_filename)
> 		config_filename = config_exclusive_filename;
> 	else
> 		config_filename = git_path("config");
>
>         return git_config_set_multivar_in_file(config_filename, key, value,
>                                                value_regex, multi_replace);

FWIW, I suspect that would be a trap waiting to be triggered as soon
as git_config_set_multivar_in_file() calls git_path() four times.
I.e., it's not about the config_exclusive_filename but about the
git_path.

A little micro-optimization might be to do the following. :)

	const char *config_filename;
	char *filename_buf = NULL;
	int result;

	if (config_exclusive_filename)
		config_filename = config_exclusive_filename;
	else
		config_filename = filename_buf = git_pathdup("config");

	result = git_config_set_multivar_in_file(...);
	free(filename_buf);
	return result;
