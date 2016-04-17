From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import's gfi_unpack_entry causes too many munmap/mmap cycles
Date: Sun, 17 Apr 2016 10:13:48 +0900
Message-ID: <20160417011348.GA17856@glandium.org>
References: <20160416091839.GA12764@glandium.org>
 <20160416110403.GA19197@glandium.org>
 <20160417005443.GA15847@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 03:14:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arbHl-000497-L9
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 03:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbcDQBN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 21:13:56 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:36630 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbcDQBNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 21:13:55 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1arbHY-0004lN-Po; Sun, 17 Apr 2016 10:13:48 +0900
Content-Disposition: inline
In-Reply-To: <20160417005443.GA15847@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291736>

On Sun, Apr 17, 2016 at 09:54:43AM +0900, Mike Hommey wrote:
> On Sat, Apr 16, 2016 at 08:04:03PM +0900, Mike Hommey wrote:
> > So I think I got myself a workaround...
> > 
> > > A --- B
> > >  \
> > >   \-- C
> > > 
> > > I have:
> > > - diff between null-tree and A
> > > - diff between A and B
> > > - diff between B and C
> > 
> > I should be able to do:
> > 
> > - start the commit command for A
> > - before finishing it, `ls ""`
> > - then apply the diff for B and `ls ""`
> > - then apply the diff for C and `ls ""`
> > - then `deleteall`
> > - then `M 040000 sha1_from_first_ls ` and finally finish A
> > - create the commit for B with `from
> >   0000000000000000000000000000000000000000\nmerge :mark` and `M 040000
> >   sha1_from_second_ls`
> > - likewise for C
> > 
> > ... and avoid gfi_unpack_entry.
> 
> And it works... as an avoidance of gfi_unpack_entry... but it has its
> own problem: somehow the store_tree() that happens for each of those
> `ls ""` commands is storing *all* trees. Even the ones that haven't
> changed. In terms of a minimalistic fast-import script:
> 
> With:
>   commit refs/FOO
>   committer <foo@foo> 0 +0
>   data 0
> 
>   M 644 inline a/a
>   data 1
>   a
> 
>   commit refs/FOO
>   committer <foo@foo> 0 +0
>   data 0
> 
>   M 644 inline b/b
>   data 1
>   b
> 
> store_tree is called for:
> - b39954843ff6e09ec3aa2b942938c30c6bd1629e
> - 2c3b59f77afa6fea6c1a380eeb0cb1eb292515b5
> - 51e58bf6ce558dd384bbf9d493f9a376f3bcb089
> - a97dda9f3a819113b3b239b9a62edece27136080
> 
> With:
>   commit refs/FOO
>   committer <foo@foo> 0 +0
>   data 0
> 
>   M 644 inline a/a
>   data 1
>   a
>   ls ""
>   M 644 inline b/b
>   data 1
>   b
> 
> store_tree is called for:
> - b39954843ff6e09ec3aa2b942938c30c6bd1629e
> - 2c3b59f77afa6fea6c1a380eeb0cb1eb292515b5
> - b39954843ff6e09ec3aa2b942938c30c6bd1629e
> - 51e58bf6ce558dd384bbf9d493f9a376f3bcb089
> - a97dda9f3a819113b3b239b9a62edece27136080
> 
> Note how b39954843ff6e09ec3aa2b942938c30c6bd1629e is being stored twice
> (it's the tree for a/).

And that happens because tree_content_get returns a duplicate of the
tree, so when parse_ls does a store_tree, it does it on a duplicate, not
on the tree itself. So all the work done by store_tree through parse_ls
is thrown away.

Mike
