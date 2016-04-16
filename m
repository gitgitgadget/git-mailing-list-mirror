From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import's gfi_unpack_entry causes too many munmap/mmap cycles
Date: Sat, 16 Apr 2016 20:04:03 +0900
Message-ID: <20160416110403.GA19197@glandium.org>
References: <20160416091839.GA12764@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 13:04:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arO1n-0007X2-IG
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 13:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbcDPLEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 07:04:11 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45272 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbcDPLEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 07:04:11 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1arO1D-00055E-D5; Sat, 16 Apr 2016 20:04:03 +0900
Content-Disposition: inline
In-Reply-To: <20160416091839.GA12764@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291720>

On Sat, Apr 16, 2016 at 06:18:39PM +0900, Mike Hommey wrote:
> And even if I am okay with that overhead, I still hit the problem again
> when using that tree later with `M 040000 $sha1 ` in the next commit,
> because that does a load_tree() for the tree sha1, after a commit having
> occurred, which touched the pack, bringing me back to square one (the
> sad part being that it does so while the tree_content for the tree in
> question is already in memory).

So, interestingly, the load_tree() doesn't happen when using `from
0000000000000000000000000000000000000000\nmerge :mark` for the commit.

That is, with:
  commit refs/foo
  committer <foo@foo> 0 +0
  data 0

  M 040000 bff3a42ecae0e7c8f707d328f9432c1ffe9644b0 ""

load_tree is called. And with:
  commit refs/foo
  committer <foo@foo> 0 +0
  data 0

  from 0000000000000000000000000000000000000000
  merge :mark_of_parent
  M 040000 bff3a42ecae0e7c8f707d328f9432c1ffe9644b0 ""

it's not called.

So I think I got myself a workaround...

> A --- B
>  \
>   \-- C
> 
> I have:
> - diff between null-tree and A
> - diff between A and B
> - diff between B and C

I should be able to do:

- start the commit command for A
- before finishing it, `ls ""`
- then apply the diff for B and `ls ""`
- then apply the diff for C and `ls ""`
- then `deleteall`
- then `M 040000 sha1_from_first_ls ` and finally finish A
- create the commit for B with `from
  0000000000000000000000000000000000000000\nmerge :mark` and `M 040000
  sha1_from_second_ls`
- likewise for C

... and avoid gfi_unpack_entry.

Mike
