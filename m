From: Kevin Ballard <kevin@sb.org>
Subject: Re: Add colors to the prompt for status indicators
Date: Mon, 15 Nov 2010 15:14:53 -0800
Message-ID: <F7A9874A-738C-4BEA-8EDF-0ED1FA7D6ACF@sb.org>
References: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com> <4CE04B82.1040804@pileofstuff.org> <19363118-D147-4946-8973-B5DDA4B00985@sb.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sebastien Douche <sdouche@gmail.com>,
	git list <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 00:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI8GO-0007yR-6A
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 00:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab0KOXO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 18:14:59 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44414 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab0KOXO6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 18:14:58 -0500
Received: by gyh4 with SMTP id 4so14294gyh.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 15:14:58 -0800 (PST)
Received: by 10.150.178.16 with SMTP id a16mr10372117ybf.437.1289862898221;
        Mon, 15 Nov 2010 15:14:58 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id m45sm306108yha.11.2010.11.15.15.14.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 15:14:57 -0800 (PST)
In-Reply-To: <19363118-D147-4946-8973-B5DDA4B00985@sb.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161524>

On Nov 15, 2010, at 2:52 PM, Kevin Ballard wrote:

>> As a fan of colourful prompts, I'd be very happy if you found a way
>> around this for parts of a script.  But as a fan of fast prompts, I'd
>> prefer not to call __git_ps1 more than once :)
> 
> I don't think there is any way around this, besides patching bash to be
> intelligent and determine which PS1 characters are printable itself without
> relying on \[ and \].

I take it back. We can use PROMPT_COMMAND for this, to set up variables
containing what you want.

Something like the following should work:

function __populate_git_ps1_vars () {
    # this relies on a bashism, so make sure you're actually using bash.
    # specifically it relies on <<<"word".
    local status
    local prompt="$(__git_ps1 "%s")"
    # empty out the vars
    __git_ps1_branch=""
    __git_ps1_staged=""
    __git_ps1_unstaged=""
    __git_ps1_stash=""
    __git_ps1_untracked=""
    __git_ps1_upstream=""
    __git_ps1_left=""
    __git_ps1_right=""
    if test -z "$prompt"; then
        # return now
        return
    fi
    __git_ps1_left=" ("
    __git_ps1_right=")"
    __git_ps1_branch="$(git rev-parse --symbolic-full-name --abbrev-ref=loose HEAD)"
    status="${prompt#$__git_ps1_branch}"
    while read -N 1 char; do
        case "$char" in
            \*) __git_ps1_unstaged="$char" ;;
            +) __git_ps1_staged="$char" ;;
            $) __git_ps1_stash="$char" ;;
            %) __git_ps1_untracked="$char" ;;
            \<|\>) __git_ps1_upstream="${__git_ps1_upstream}$char" ;;
        esac
    done <<<"$status"
}

PROMPT_COMMAND=__populate_git_ps1_vars

PS1='\w${__git_ps1_left}${__git_ps1_branch}\[\e[31m\]${__git_ps1_staged}\[\e[34m\]${__git_ps1_unstaged}\[\e[32m\]${__git_ps1_stash}\[\e[1;34m\]${__git_ps1_untracked}\[\e[31m\]${__git_ps1_upstream}\[\e[m\]${__git_ps1_right}> '

-Kevin Ballard