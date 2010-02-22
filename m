From: Avi Kivity <avi@redhat.com>
Subject: Feature request: separate namespace for remote tags
Date: Mon, 22 Feb 2010 14:44:56 +0200
Message-ID: <4B827C48.9060601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 14:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjXeq-0002ff-7v
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 13:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab0BVMo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 07:44:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6981 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab0BVMo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 07:44:58 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1MCivdj001131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Mon, 22 Feb 2010 07:44:57 -0500
Received: from cleopatra.tlv.redhat.com (cleopatra.tlv.redhat.com [10.35.255.11])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o1MCiurH008325
	for <git@vger.kernel.org>; Mon, 22 Feb 2010 07:44:57 -0500
Received: from balrog.qumranet.com (dhcp-1-27.tlv.redhat.com [10.35.1.27])
	by cleopatra.tlv.redhat.com (Postfix) with ESMTP id 8B7E1250057;
	Mon, 22 Feb 2010 14:44:56 +0200 (IST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140681>

Currently, 'git remote add foo ...' will allocate a separate namespace 
for foo branches (refs/remotes/foo/*) but will store foo tags in the 
main tag namespace (refs/tags/*).  This leads to several problems:

- the main tag namespace becomes polluted with zillions of tags
- if the tags from a remote conflict with a local (or perhaps another 
remote) tag, information is lost
- 'git remote rm' will not delete the remote tags, and so 'git gc' will 
not recover much of the space used by the remote

A workaround is to use tagopt = --no-tags and a separate fetch line in 
the remote configuration, but that is clumsy and error prone (a common 
error being to remember doing that only after the first fetch).  I'd 
like to request that remote tags be placed into a separate namespace 
(refs/remote-tags/foo/*?) that can be managed by 'git remote' subcommands.

My suggestion is:

- 'git clone' and subsequent fetches would continue to place tags in the 
global namespace (unless overridden by a switch)
- 'git remote add', if a switch of config flag is present, will place 
tags in a remote namespace; after a while the config flag can default to 
true
- 'git describe' will prefer local tags to remote tags
- the various commands which look at tags will be enhanced to consider 
remote tag namespaces
- possibly ignore remote tags which have the same name and value as 
existing local tags (so we don't have identical v1.7.0 and foo/v1.7.0)

Thoughts?

-- 
error compiling committee.c: too many arguments to function
