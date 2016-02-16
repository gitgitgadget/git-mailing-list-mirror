From: Brian Norris <computersforpeace@gmail.com>
Subject: [BUG] git-log: tracking deleted file in a repository with multiple
 "initial commit" histories
Date: Tue, 16 Feb 2016 12:24:42 -0800
Message-ID: <20160216202442.GH21465@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 21:24:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVmB0-000785-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 21:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbcBPUYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 15:24:47 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33678 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535AbcBPUYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 15:24:45 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so110794527pfb.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=MDd3pv9zm8A3vKLUr4FjD4fldsbozKdELtl5/c1WroY=;
        b=jJ3xYFppar82rISPZq3mwA2sizvE+FAYuea+P0P+blnrQ/wg1s46xfgZCgM09w0f4K
         TzXNNIkNGAhOzjPxCpsCtsHTLX5rXdsztrr3x7n8ZnJonTpAYqKC+4CjuyGwbHM5jZRf
         zBcD5PILzJvssICL6asvZQPeaV9ehZ1BdpCqfOWVoIC/eQzbD43AITZDQWs4l5VCuAKL
         w1KBBO8lyD/IEHUbrNJhPy9BVbhqdbKpNz/KbQF3vVGD5P1GLP3XZMt8TCjGeXHUwnQl
         K/3iTwVYkP3hbRV0L8UzpQyX3UnveTpcWWW6RC4yAQk9chDDu6QoB1MtWCg0sWQKWRIY
         A9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=MDd3pv9zm8A3vKLUr4FjD4fldsbozKdELtl5/c1WroY=;
        b=VYHyUee42z2sJgcG28fiGdbymo/IpenyAygH4c8nk6Y/TAZiUXrIxr626SDznknJf4
         xwoPTDEHcnbceX2/G9lzPiDFYMgl8PTkipcEsOo8YBOMlPX7TO5FxwwjOUpQZTtBC+i3
         SK1ovBRbZ5SKKS4lbGStaBGqtASELGxZfVbS4rYGHRSs636yLxLxXEPVCk5qpa1keE5o
         lc4RCHyK+foJgo/xHmoAI3pOys3Q8ZohEXxqIHeaH/D/TRS3zfe158+qtH+U7tGrdZiD
         lNErzfgcSHRLxuWIDfkGC9hRn3N7TDlnfe86HuOVMjDduX64GWZyZvd5BDuHvHtLTdz0
         MjJA==
X-Gm-Message-State: AG10YOTHMwu/h54R+6H/9tocv+NTr5cCgnf4n4i8UXPMqzqtLqT+YJXAlHmJDczlGnArpw==
X-Received: by 10.98.1.85 with SMTP id 82mr34625245pfb.10.1455654285487;
        Tue, 16 Feb 2016 12:24:45 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:c8ef:c336:6e13:f533])
        by smtp.gmail.com with ESMTPSA id fa3sm47783108pab.45.2016.02.16.12.24.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 12:24:44 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286428>

Hi,

I'm not sure if this is a known behavior or a new bug report. I at least
couldn't find anyone mentioning this exact problem.

I'm using a git repository that has multiple "inital commits" (i.e., a
few different directory trees were imported via svn-to-git as different
branches) whose histories have been merged together to the single master
branch, and the file I want to track is both added and removed in only
one of those lineages. When I try to do:

  $ git log -- <file>

on the deleted file in the master branch, I get no history. But if I
checkout the particular sub-tree of the merge history, then git-log
returns the appropriate history.

For specifics, I'm looking at this repo:

  https://chromium.googlesource.com/chromiumos/platform2

and this file:

  init/iptables.conf

which is added in this commit:

  882271d255f4 Still more platform modules.

and deleted here:

  65a8de6f85b8 chromeos-init: Remove firewall upstart jobs from platform/init

and whose branch of history is merged in via the following merge commit:

  8f4314b70b78 Move 'src/platform/init' to 'src/platform2'

.

Test 1:

  $ git checkout 8f4314b70b78
  $ git log -- init/iptables.conf
  ## No output

Test 2:

  $ git checkout 8f4314b70b78^2
  $ git log -- init/iptables.conf
  ## See proper history

The behavior of Test 1 seems like a bug to me. Thoughts?

Regards,
Brian
