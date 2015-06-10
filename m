From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/19] pull: check if in unresolved merge state
Date: Tue, 09 Jun 2015 18:29:01 -0700
Message-ID: <xmqqsia0uzaa.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-12-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 03:29:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2UpK-0005WD-NS
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 03:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbbFJB3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 21:29:06 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33338 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbbFJB3E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 21:29:04 -0400
Received: by iebgx4 with SMTP id gx4so24964279ieb.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 18:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NuFxlcTbFYrWKoNrlYc0QDLmFYbbglWNzEbffxbHM1g=;
        b=On+eiov9NFEncimbDOVG9YQKABjvy7KOw3QuDsg5rtaBnxMarInUSg2e88bPHisKmo
         46t0GyVxEvfOYtMw6zpIRm9ISTRCa6tin81SatdV1kTHH6ZPv1QjIzhGxpjyed+1LQ6d
         mZ98TXNH5NRgX1QQIrPIFz29QWesabMvrIO92KCP2q/cJ1uiN9LxA35p1vhevZuVhvED
         qAnCpfjjiImoBjSJPFSatj2H9A3RkF5hC9Z+RUwzDprWosIhWamMFkjrt+8JnbymKQwo
         JcAEncoSstOf9VzzZ+shtDwlLr51w+G6kEscvjEbgG1XtbpB4YOs7X6V/IlaFo0OkTMs
         6q1A==
X-Received: by 10.50.138.232 with SMTP id qt8mr24289301igb.28.1433899744134;
        Tue, 09 Jun 2015 18:29:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id d4sm5147931iod.17.2015.06.09.18.29.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 18:29:02 -0700 (PDT)
In-Reply-To: <1433314143-4478-12-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 3 Jun 2015 14:48:55 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271249>

Paul Tan <pyokagan@gmail.com> writes:

> @@ -422,6 +423,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	parse_repo_refspecs(argc, argv, &repo, &refspecs);
>  
> +	git_config(git_default_config, NULL);
> +
> +	if (read_cache_unmerged())
> +		die_resolve_conflict("Pull");
> +
> +	if (file_exists(git_path("MERGE_HEAD")))
> +		die_conclude_merge();
> +
>  	if (!opt_ff.len)
>  		config_get_ff(&opt_ff);

Hmph.

If you are going to do the git_config() call yourself, it might make
more sense to define git_pull_config() callback and parse the pull.ff
yourself, updating the use of the lazy git_config_get_value() API you
introduced in patch 10/19.

The above "might" is stronger than my usual "might"; I am undecided
yet before reading the remainder of the series.
