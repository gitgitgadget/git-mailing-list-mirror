From: David Kastrup <dak@gnu.org>
Subject: Re: Can someone explain this git-blame/git-rev behavior to me?
Date: Mon, 16 Jul 2007 22:41:36 +0200
Message-ID: <85lkdgm67z.fsf@lola.goethe.zz>
References: <86sl7oaasx.fsf@lola.quinscape.zz>
	<469B71A5.D5299A80@eudaptics.com> <86ps2s736g.fsf@lola.quinscape.zz>
	<469B9843.835B5356@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:42:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAXOU-000672-EE
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 22:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbXGPUmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 16:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbXGPUmD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 16:42:03 -0400
Received: from main.gmane.org ([80.91.229.2]:60805 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbXGPUmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 16:42:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAXOD-0002aK-1U
	for git@vger.kernel.org; Mon, 16 Jul 2007 22:41:53 +0200
Received: from dslb-084-061-090-188.pools.arcor-ip.net ([84.61.90.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 22:41:53 +0200
Received: from dak by dslb-084-061-090-188.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 22:41:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-090-188.pools.arcor-ip.net
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:x4qVabegSBWDcRB7Oj1fw+eHJU4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52720>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> David Kastrup wrote:
>> 
>> I am looking for a descendant of tags/v1.4.4-rc1~72 with regard to
>> contrib/emacs/vc-git.el by scanning the output of the first command
>> in the following pipeline:
>> 
>> git-rev-list --parents HEAD ^tags/v1.4.4-rc1~72 -- vc-git.el|git-name-rev --stdin|fgrep tags/v1.4.4-rc1
>> 
>> This gives:
>> 4de0f9f9b6ed1731de00b67952504e5a783f54a4 (tags/v1.5.0-rc0~31) 1259404c7e5cd88b7f6692986469cd20cbfacdad (tags/v1.4.4-rc1~71)
>> 1259404c7e5cd88b7f6692986469cd20cbfacdad (tags/v1.4.4-rc1~71) b4aee09e610567529dc619d7324dc2fe85a11db5 (tags/v1.4.4-rc1~72) 0abc0260fa3419de649fcc1444e3d256a17ca6c7 (tags/v1.4.3.2~6)
>> 
>> And this looks like it would tell us that tags/v1.4.4-rc1~72 has with
>> regard to vc-git.el a child tags/v1.4.4-rc1~71 and a grandchild of
>> tags/v1.5.0-rc0~31.
>> 
>> Now if I instead do
>> git-rev-list --parents HEAD -- vc-git.el|git-name-rev --stdin|fgrep tags/v1.4.4-rc1
>> 
>> 4de0f9f9b6ed1731de00b67952504e5a783f54a4 (tags/v1.5.0-rc0~31) b4aee09e610567529dc619d7324dc2fe85a11db5 (tags/v1.4.4-rc1~72)
>> b4aee09e610567529dc619d7324dc2fe85a11db5 (tags/v1.4.4-rc1~72) 474a90fef9ebcdedee041b2def4b9a98b94cd146 (tags/v1.4.3.2~8)
>> 
>> I get to see that the child of tags/v1.4.4-rc1~72 is actually
>> tags/v1.5.0-rc0~31, skipping tags/v1.4.4-rc1~71 which presumably did
>> not change vc-git.el.
>> 
>> So the ^tags/v1.4.4-rc1~72 specification caused an additional mention
>> of tags/v1.4.4-rc1~71 even though, with regard to vc-git.el, it would
>> be equivalent to tags/v1.4.4-rc1~72.
>> 
>> So is there a way I can get the information of the second call without
>> the performance loss of going through the entire history?
>
> It seems that there is an unwanted interaction between --parents and
> history simplification at the edge commits. I don't think that there
> will be an easy solution.

After some testing, it would appear that indeed the --parents option
causes the problematic behavior.  I find this surprising since
--parents should not have an effect on which lines are getting
displayed, should it?  It should just make those lines that _are_
getting displayed longer.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
