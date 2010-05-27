From: Adam Monsen <haircut@gmail.com>
Subject: Re: request for help with buildnumber-maven-plugin git integration
Date: Thu, 27 May 2010 04:15:35 +0000 (UTC)
Message-ID: <loom.20100527T061506-817@post.gmane.org>
References: <loom.20100514T010951-900@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 27 06:15:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHUVb-0007YK-Bg
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 06:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807Ab0E0EPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 00:15:46 -0400
Received: from lo.gmane.org ([80.91.229.12]:43524 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab0E0EPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 00:15:45 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OHUVS-0007Ve-Sn
	for git@vger.kernel.org; Thu, 27 May 2010 06:15:43 +0200
Received: from c-67-183-136-182.hsd1.wa.comcast.net ([67.183.136.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 May 2010 06:15:42 +0200
Received: from haircut by c-67-183-136-182.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 May 2010 06:15:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.183.136.182 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 ( .NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147827>

I wrote, about a week ago:
> Maven is a build system used by many Java-based projects. Some
> folks have added Git support, allowing the inclusion of build
> identifiers (like branches and commit hashes) in products of Maven
> builds. But they need help to complete it. Is anyone interested in
> helping?
>
> This is something we (Mifos) need, so if you do help, know that
> you'll be helping to end world poverty.

FYI, I gave up trying to fix the integration tests, or to modify the
plugin to suit my needs. I instead used groovy script right in my
POM, and set project properties that are filtered into a file
included in our war.

Here's the Groovy snippet I used, modified to have shorter names to
prevent wrapping:

  def env = System.getenv()
  def gitcmd = "git"
  if (env['OS'] =~ /^Windows/)
      gitcmd = "cmd /c ${gitcmd}"
  def gcmd = """${gitcmd} log --pretty=format:%H -n1""".execute()
  project.properties['mifos_commit'] = gcmd.in.text
  project.properties['mifos_build'] = env['BUILD_TAG'] ?: 'DEV'
  project.properties['mifos_date'] = "" + new Date()

"BUILD_TAG" is something set by the Hudson continuous integration
server (that's what we use).

Here's the script, in vivo (commit 5dfe4d1abda09713b296ea2524):
http://tinyurl.com/3xcxp9n

I figured trading lots of lines of Java, XML, etc. for 8 lines of
maintainable/portable Groovy was a good move.

Hope this helps someone else using Maven and git who needs build
identifiers available as properties,
-Adam
