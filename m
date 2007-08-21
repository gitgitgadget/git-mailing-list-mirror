From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Centralized processes in git
Date: Tue, 21 Aug 2007 08:36:40 +0800
Message-ID: <46CA3398.9060803@midwinter.com>
References: <31FEEAE6-58A6-4A74-9DB7-E6F9D56D1C48@rlb3.com> <20070820192947.GD8542@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Boone <robert@rlb3.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Aug 21 02:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INHjl-00026o-Dq
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 02:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbXHUAgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 20:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbXHUAgp
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 20:36:45 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:44702 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751426AbXHUAgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 20:36:45 -0400
Received: (qmail 18214 invoked from network); 21 Aug 2007 00:36:44 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=bKkaM2CZ6eT88NltZA/9p1PJsfRCk2rMAqI0owLnzuO/kFjjIcFpugQwaXEqkOPu  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 21 Aug 2007 00:36:44 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20070820192947.GD8542@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56269>

Jan Hudec wrote:
> Commit would undo any changes pushed between checking out a branch and
> commiting, so you should probably do the merges on a separate repository,
> that will only be managed by the scripts. You can use the alternates
> mechanism to avoid duplicating the data if that repository will be on the
> central server.
>   

That makes this kind of operation ten times more complicated than it 
ought to be, IMO.

I wonder if it makes sense to expose a repository locking mechanism for 
this kind of application. The builtin git commands would test for the 
lock and block (waiting up to some configurable timeout) until it went 
away, but wouldn't necessarily ever actually lock things themselves. Or 
maybe a shared/exclusive lock (aka an rwlock) would be appropriate here; 
the repository-altering commands would grab a shared lock.

A lock-and-block primitive eliminates the need for a separate work queue 
manager for stuff like this: you just make sure you exclusive-lock the 
repo before you start your postprocessing (and make sure your 
postprocessing handles the case where another commit landed before you 
got launched, of course). Then you know that nothing else will screw 
with the repo while you're working, and that your execution will be 
serialized. If you don't need serialized operation like that, you just 
never grab the exclusive lock and things continue to work as today.

Stupid idea? The wrinkle, of course, is that you need to run git 
commands from within your script, so *those* can't block. I can think of 
a few easy ways around that, though, e.g., use an environment variable 
to identify yourself as the holder of the lock, perhaps by putting your 
PID in the lockfile and setting the variable to your PID.

-Steve
