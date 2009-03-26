From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Re: Use alternate GIT servers to share traffic
Date: Thu, 26 Mar 2009 10:40:19 -0300
Organization: DATACOM
Message-ID: <49CB85C3.20700@datacom.ind.br>
References: <200903252145.30226.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:43:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmprK-00073W-2u
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 14:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbZCZNkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 09:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755491AbZCZNkf
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 09:40:35 -0400
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:52365 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754368AbZCZNke (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 09:40:34 -0400
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id B4F682ACDD; Thu, 26 Mar 2009 10:40:23 -0300 (BRT)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id 455432ACD8;
	Thu, 26 Mar 2009 10:40:21 -0300 (BRT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <200903252145.30226.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114776>

Thomas Koch wrote:
> Hi,
> 
> we host a public GIT repository on our high availability company
> cluster. Cloning the repo causes a trafic volume of 326 MB. We'd like to
> avoid that much trafic while still leaving the GIT repo where it is.
> 
> I could imagine the following conversation between the GIT client and
> server:
> 
> Client: Wanna clone!
> Server: You're welcome. Please note, that while I serve the most current
> state, you can get objects much faster from my collegue Server
> CHEAPHOST.
> Client: Thank you. Will take all the objects I can get from CHEAPHOST
> and come back if I should need anything else!
> 
> The enduser should not need to specify anything, but only the regular
> git clone EXPENSIVEHOST line.
> 
> Your thoughts?
> 

I have a scenario here that is (nearly) similar to what you want. 
We have two development sites and we let users choose the server that is closer to them.
As all changes to these repositories are made using push, we use post-receive hooks to syncronize.
User can push no any of the servers and the changes will get replicated.

In the EXPENSIVEHOST you add the CHEAPHOST as remote and put a 'git push --mirror cheaphost' in the post-receive hook.

In the CHEAPHOST, you add EXPENSIVEHOST as remote and changes git config to make it put the references in refs/heads/* instead of refs/remotes/expensivehost/*.  In the post-receive hook you add a 'git push --all expensivehost'.

Also, you need to ensure that all users can authenticate in both servers (or, in my case, I made the hook use sudo to push the updates using a special user that authenticate using ssh keys).

The drawback ares:

1) User must manually choose the closest server. (maybe some sort of round-robin DNS would do it automatically?)

2) Branch and tag deletion must be done in the EXPENSIVEHOST.

3) EXPENSIVEHOST stores the remote refs from CHEAPHOST in remotes/cheaphost/* and they are pushed back to CHEAPHOST by push --mirror. These references are not used at all, but they can cause some noise in the log message during pushes.

4) If we have two users committing to the same branch exactly at the same time in the different servers, I'm not sure about what will happen :-). As precaution, I added in CHEAPHOST a cron job that does a 'git remote update' in the repo. So, if the servers became inconsistent, it will perform a forced update from EXPENSIVEHOST to CHEAPHOST. 

I have the scenario running just for a few days, so there may be some additional corner cases.

HTH,

 - Samuel
