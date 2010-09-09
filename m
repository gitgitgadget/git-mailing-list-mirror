From: Jeremiah Foster <jeremiah@jeremiahfoster.com>
Subject: Re: Git with http and no Dav?
Date: Thu, 9 Sep 2010 11:47:11 +0200
Message-ID: <5212C024-67BA-4FD1-A3BB-2BC8434444C4@jeremiahfoster.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 11:54:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtdqC-0006GP-7S
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 11:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab0IIJyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 05:54:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751348Ab0IIJyj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 05:54:39 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2010 05:54:38 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75BBBC6141
	for <git@vger.kernel.org>; Thu,  9 Sep 2010 05:47:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from
	:content-type:content-transfer-encoding:subject:date:message-id
	:to:mime-version; s=sasl; bh=TLIOxpZ36F7b9KfiFzvg2ETmrDI=; b=wjf
	W75S/mpS6TxQVldqMg6L9R3nUiwGmL6Ki79hjS2KLkuVkhbIMCNbGXXwgFlf1MWz
	mp6Ru7p8wgb7k9a704YwuOqW0fYZwty7pq2LygQfS+F7SmbxDnN726hVQ3ioV3dr
	fkjAsjxqEZ9oLjig/3jiKevfPnoOP1sfLbc4WRpQ=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 710CDC6140
	for <git@vger.kernel.org>; Thu,  9 Sep 2010 05:47:13 -0400 (EDT)
Received: from [10.8.36.188] (unknown [194.237.7.146]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFC97C613F for
 <git@vger.kernel.org>; Thu,  9 Sep 2010 05:47:12 -0400 (EDT)
X-Mailer: Apple Mail (2.1081)
X-Pobox-Relay-ID: 39238962-BBF7-11DF-AF09-A3DF016DD5F0-97416961!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155854>


> Hi all!
> 
> I am starting to make some public repositories available, although I am struggling with the HTTP backend! 

There is an elegant solution called the http smart backend. Here's some info from Scott Chacon who wrote the Pro Git book: http://progit.org/2010/03/04/smart-http.html

That is a great link to get started, but it is a little terse. Here is some more info on the http backend:
http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html

> 
> My setup is currently this: authorized users make use of ssh in order to clone/push, and this works like a charm. A public view (only view!) of repositories can be obtained by gitweb, and this also works flawlessly. 
> 
> On my debian server though, I don't know how to enable public cloning via http, since I don't really want to use WebDAV, as explained on the "setup-git-server-over-http.txt" howto. 
> 
> As suggested, I issued the "git update-server-info" command in the repository location, however, this has no effect on the repository:

If you want to use the http backend, you'll need to reconfigure your apache configuration. Specifically what you'll need to do is re-map the calls to git so that they go instead to the http backend which will do all the heavy lifting. 

Here's an example; 

    SetEnv GIT_PROJECT_ROOT /srv/git
    AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /srv/git/$1
    AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /srv/git/$1
    ScriptAlias /srv/git/ /usr/lib/git-core/git-http-backend/

    ScriptAliasMatch \
    "(?x)^/git/(.*/(HEAD | \                                                                                                                                                                                  
    info/refs | \                                                                                                                                                                                             
    objects/(info/[^/]+ | \                                                                                                                                                                                   
    [0-9a-f]{2}/[0-9a-f]{38} | \                                                                                                                                                                              
    pack/pack-[0-9a-f]{40}\.(pack|idx)) | \                                                                                                                                                                   
    git-(upload|receive)-pack))$" \
    /usr/libexec/git-core/git-http-backend/$1

You can see from above that what is happening is that calls to the git objects are getting caught and then passed, via script alias, to the git-http-backend program.

Also note that this particular snippet says nothing about authentication or authorization - those are things you'll need to configure as well, perhaps with but also possibly without ssh. The http backend gives you great flexibility and allows you to replace ssh key management with a more centralized authentication mechanism.

If you read those two URLs I presented, that should give you a good start on your way. 

Regards,

Jeremiah
