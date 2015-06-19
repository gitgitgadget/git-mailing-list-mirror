From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool-lib: fix default tool selection
Date: Fri, 19 Jun 2015 10:39:08 -0700
Message-ID: <xmqqbngba98j.fsf@gitster.dls.corp.google.com>
References: <a9844fc48424d5caf27cc2189af3d9d867d01833.1434706187.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 19:39:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z60GI-0006d0-JO
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 19:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbbFSRjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 13:39:12 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:32831 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbbFSRjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 13:39:10 -0400
Received: by iebgx4 with SMTP id gx4so79203024ieb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SGyLS1oUHMOEe2vegAb4Coj0Ijzl4SyyW13nYfF0UAM=;
        b=lws4B3exDYqKwubjvD7za85TITeYOYnU6GabqjYYGzH9GEyb7g1qqmtWtRDZgwrBav
         u3nbRwb+zmAqKiMozAkrdgY8W8okFS9rM+Q3i82Fu7UiL7BQJLwOm0KEq1mC2gjdo/yA
         0L6iuAhpKKEOpN1O+IDOuQ828UMZs1ffhSA4vNE5zVEQex+bPgVMSQ3il1Iq/YHfsdkh
         dWhcJO4PHspW+GzPGC8XTfcB36up6ek55PkoVIjLyw6jq3CUzmGfzQcOQ1cKDOoG+Oxp
         36gDLv86IlkAdYuPn4zZFqqB640XbDBFDtnxGmTuipo44oSSeQnWTxIFdI+2wCJLEWKf
         jCHQ==
X-Received: by 10.50.138.70 with SMTP id qo6mr5959742igb.15.1434735549689;
        Fri, 19 Jun 2015 10:39:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id s5sm2101539igh.6.2015.06.19.10.39.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 10:39:09 -0700 (PDT)
In-Reply-To: <a9844fc48424d5caf27cc2189af3d9d867d01833.1434706187.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 19 Jun 2015 11:30:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272172>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When no diff nor merge tool is specified (config, option), mergetool-lib
> is supposed to choose a default tool from a set of tools. That set is
> constructed dynamically depending on the environment (graphical, editor
> setting) as a space separated string of tool names.
>
> 719518f (mergetool--lib: set IFS for difftool and mergetool, 2015-05-20)
> introduced a newline as IFS which breaks the parsing of the space
> separated list into items, resulting in a failed search for an available
> tool.
>
> Set IFS to a space locally for the tool search.

I wondered where this "locally" is ensured; it turns out that this
shell function is supposed to be always called inside $() to return
its result via its standard output ;-)

So I think this change makes sense.

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  git-mergetool--lib.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 14b039d..54ac8e4 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -305,6 +305,7 @@ guess_merge_tool () {
>  	EOF
>  
>  	# Loop over each candidate and stop when a valid merge tool is found.
> +	IFS=' '
>  	for tool in $tools
>  	do
>  		is_available "$tool" && echo "$tool" && return 0
