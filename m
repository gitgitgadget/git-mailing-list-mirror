From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH] submodule: Demonstrate known breakage during recursive
 merge
Date: Wed, 24 Aug 2011 16:40:50 -0400
Message-ID: <4E5561D2.2080206@kitware.com>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net> <4E5558BB.4040307@kitware.com> <20110824202721.GF45292@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:41:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwKGM-0007TI-Qe
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab1HXUlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:41:23 -0400
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:51923 "HELO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752756Ab1HXUlV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 16:41:21 -0400
Received: from mail-gx0-f176.google.com ([209.85.161.176]) (using TLSv1) by na3sys009aob125.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTlVh8O8h96zzN4MbLnbauXPqSQwbpYNF@postini.com; Wed, 24 Aug 2011 13:41:21 PDT
Received: by mail-gx0-f176.google.com with SMTP id 7so1488446gxk.21
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 13:41:20 -0700 (PDT)
Received: by 10.91.164.21 with SMTP id r21mr5286413ago.118.1314218480624;
        Wed, 24 Aug 2011 13:41:20 -0700 (PDT)
Received: from [192.168.1.220] (66-194-253-20.static.twtelecom.net [66.194.253.20])
        by mx.google.com with ESMTPS id j30sm1187547ann.48.2011.08.24.13.41.19
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 13:41:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <20110824202721.GF45292@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180039>

On 8/24/2011 4:27 PM, Heiko Voigt wrote:
>>>      b---bc
>>>     / \ /
>>>    o   X
>>>     \ / \
>>>      c---cb
[snip]
> Supposing you merge bc into cb:
> If I understand the situation correctly, the above is done first with
> a := cb:sub, b := bc:sub, base := b:sub and then another time with
> base := c:sub.

When merging bc and cb there are two merge bases: b and c.  The recursive
merge strategy first performs a "virtual" merge between b and c and uses
the result as a fictional merge base between bc and cb.  Currently the
submodule merge search runs during the "virtual" merge and gives advice.
Then it later dies while trying to search during the "real" merge.

After applying my patch, try this:

  $ cd t && ./t7405-submodule-merge.sh --verbose
  ...
  Merging:
  8cbd0fb cb
  virtual top-bc
  found 2 common ancestor(s):
  f6b4d5a b
  4d9cfab c
    Merging:
    f6b4d5a b
    4d9cfab c
    found 1 common ancestor(s):
    a2ff72f a
  warning: Failed to merge submodule sub (multiple merges found)
   806049692f8921101f2e7223852e3bd74f7187c8: > Merge branch 'sub-c' into sub-bc
   db70dfacda48ce55365256a58eaf89b7da87cbe7: > Merge branch 'sub-b' into sub-cb
    Auto-merging sub
    CONFLICT (submodule): Merge conflict in sub
  fatal: --ancestry-path given but there are no bottom commits

One can see that the advice given talks about merging "b:sub" and "c:sub"
and the suggested commits are actually "bc:sub" and "cb:sub".  This advice
is not useful to someone mergeing bc and cb.

-Brad
