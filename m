From: David Rothenberger <daveroth@acm.org>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and
 skelta mode
Date: Fri, 05 Jul 2013 16:14:12 -0700
Message-ID: <kr7jvu$62n$1@ger.gmane.org>
References: <kr7beq$ilk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 06 01:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvFCv-0003gB-Rx
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 01:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab3GEXO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 19:14:26 -0400
Received: from plane.gmane.org ([80.91.229.3]:44414 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab3GEXOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 19:14:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UvFCp-0003am-Fq
	for git@vger.kernel.org; Sat, 06 Jul 2013 01:14:23 +0200
Received: from c-24-16-16-7.hsd1.wa.comcast.net ([24.16.16.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 01:14:23 +0200
Received: from daveroth by c-24-16-16-7.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 01:14:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-16-7.hsd1.wa.comcast.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <kr7beq$ilk$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229684>

On 7/5/2013 1:48 PM, David Rothenberger wrote:
> I recently upgraded my Subversion server to 1.8.0 and started
> receiving the following error from "git svn fetch":
> 
> Temp file with moniker 'svn_delta' already in use at /usr/lib/perl5/vendor_perl/5.10/Git.pm line 1024.
> 
> This occurs only when using an http:// URL; svn:// URLs work fine.

I traced git-svn and discovered that the error is due to a known
problem in the SVN APIs. ra_serf does not drive the delta editor in
a depth-first manner as required by the API [1]. Instead, the calls
come in this order:

 1. open_root
 2. open_directory
 3. add_file
 4. apply_textdelta
 5. add_file
 6. apply_textdelta

This is a known issue [2] and one that the Subversion folks have
elected not to fix [3].

[1]
http://subversion.apache.org/docs/api/latest/structsvn__delta__editor__t.html#details
[2] http://subversion.tigris.org/issues/show_bug.cgi?id=2932
[3] http://subversion.tigris.org/issues/show_bug.cgi?id=3831

-- 
David Rothenberger  ----  daveroth@acm.org

management, n.:
        The art of getting other people to do all the work.
