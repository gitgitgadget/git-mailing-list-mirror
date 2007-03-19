From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Why are ref_lists sorted?
Date: Mon, 19 Mar 2007 03:38:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 04:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8hE-0001Fz-Ky
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbXCSDiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbXCSDiH
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:38:07 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34506 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965085AbXCSDiG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 23:38:06 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 75D99C61A6
	for <git@vger.kernel.org>; Mon, 19 Mar 2007 03:38:04 +0000 (GMT)
Received: (qmail 4782 invoked by uid 103); 19 Mar 2007 03:38:04 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2869. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032697 secs); 19 Mar 2007 03:38:04 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 19 Mar 2007 03:38:03 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42578>

Having got a C implementation of fetch far enough to be able to tell me 
that I'm up-to-date (when using git:// and not using remotes or branches 
files) I thought I'd compare performance with the fetch--tool based 
version.  I was a bit surprised at what I saw.

Hot-cache time went from ~30s to ~3s, which didn't seem too bad.  However 
what did puzzle me was where the C version was spending it's time.  Being 
a work in progress it's a bit chatty in places, but there is an up-front 
delay of just over 1s (i.e. before my first message, which is the name of 
the remote to fetch).

A bit of investigation showed this to be due to the first attempt to read 
a ref causing the packed refs to be loaded.  In my test repo the 
packed-refs file has over 9000 entries, but I still thought that it would 
load faster than that.  It turns out that the overhead is from sorting the 
refs when building the ref_list.  If I remove the code for sorting the 
entries I lose that initial 1s delay, without appearing to break anything 
in the fetch.  However I assume that it's there for a reason ...

So my questions are:

1) what have I broken by removing the sort?
2) is it worth trying to optimise the sort?

-- 
Julian

  ---
<SpanKY> http://www.ananova.com/news/story/sm_806582.html?menu=news.quirkies
<Mr_Bones_> SpanKY: my life would have been much improved without that
  link.
