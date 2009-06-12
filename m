From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 14:18:43 -0500
Message-ID: <zcwHUAotNPBrTDFNEkfJbIprL0vwx_PJ65xUGwV0moW81e1bhyxgMg@cipher.nrlssc.navy.mil>
References: <20090612084207.6117@nanako3.lavabit.com> <4A32366A.6090608@op5.se> <1244807741-sup-7206@ntdws12.chass.utoronto.ca> <20090612140229.GA14628@coredump.intra.peff.net> <1244817396-sup-7368@ntdws12.chass.utoronto.ca> <20090612144857.GA20691@coredump.intra.peff.net> <1244818580-sup-60@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, GIT List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Jun 12 21:19:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFCHm-0005sT-Eq
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 21:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758182AbZFLTTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 15:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757378AbZFLTTX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 15:19:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58328 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696AbZFLTTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 15:19:23 -0400
Received: by mail.nrlssc.navy.mil id n5CJIi5e003475; Fri, 12 Jun 2009 14:18:44 -0500
In-Reply-To: <1244818580-sup-60@ntdws12.chass.utoronto.ca>
X-OriginalArrivalTime: 12 Jun 2009 19:18:43.0443 (UTC) FILETIME=[99C64430:01C9EB92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121442>

Ben Walton wrote:
> Excerpts from Jeff King's message of Fri Jun 12 10:48:57 -0400 2009:
>> [any reason not to keep this on the git list?]
> 
> ...no, I just forget to set the CC.
> 
>> On Fri, Jun 12, 2009 at 10:36:46AM -0400, Ben Walton wrote:
>>
>>> I've aliased 'ci' to 'commit -s', and people either use the alias or
>>> are encouraged to add the -s (it is by convention only, after all).
>>> We've then setup the root shell such that $USER is leveraged to source
>>> in some personalized shell when su is used.  This is where we set
>>> GIT_COMMITTER_* on a per-admin basis.  People not doing that edit the
>>> SoB line while editing the commit message...this fails with 'ci -m'.
>> Makes sense. I have a similar setup where people could be identified by
>> the ssh keys they use to log in, but I have never gotten around to
>> setting up something automated.
>>
>> I suspect SoB may be more convenient than GIT_AUTHOR_* in your scenario
>> just because you can tweak the former in the editor, as you note (and it
>> sounds like it's possible to not have the other variables set up
>> properly in your setup).
> 
> It is easier from that perspective, but since nothing is forcing the
> use of -s, we'd have the same compliance if we wanted to ask people to
> use --author (or set the proper environment).
> 
>>> Actually, I'm still wavering on which I'd prefer.  At this point,
>>> since git is still fairly new for us in this capacity, we're feeling
>>> our way through things.  I went with COMMITTER instead of AUTHOR
>>> though since that tends to stand out more in `git log` (at least to my
>>> eyes).  Since we're not a finger pointing group :), things like `git
>> I would argue that you should do the opposite. AUTHOR is really about
>> "who wrote this change" and COMMITTER is about "who put this change into
>> the repo". So to me, "Bob wrote the change, logged in as root@box2, and
>> committed" should be AUTHOR=Bob, COMMITTER=root@box2.
> 
> Your described usage is more semantically correct.  It may make sense
> for us to switch to AUTHOR, so that in the future we could pinpoint
> changes with less hassle.  I'll be discussing this with my colleagues
> shortly.

We use a shared account for updating a specific git repository.  I have
this bit of shell in the .bash_profile of that account to automatically
prompt and set GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL when someone tries
"git commit':


_setup_git_ident ()
{
   local userid
   local ypentry

   while read -p "Your Real Login ID (not \"$LOGNAME\")> " userid
   do
       ypentry=$(ypmatch "$userid" passwd) || continue
       break
   done

   oldIFS=$IFS
   IFS=:
   set -- $ypentry
   IFS=$oldIFS

   GIT_AUTHOR_NAME=${GIT_AUTHOR_NAME:-"$5"}
   GIT_AUTHOR_EMAIL=${GIT_AUTHOR_EMAIL:-"$1@"$(dnsdomainname)}

   export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
}

_run_git ()
{
   if [ "x$1" = "xcommit" ] &&
      [ -z "$GIT_AUTHOR_NAME" -o -z "$GIT_AUTHOR_EMAIL" ]
   then
       _setup_git_ident
   fi

   git "$@"
}

alias git=_run_git
