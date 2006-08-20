From: Rutger Nijlunsing <rutger@nospam.com>
Subject: [ANNOUNCE] git-rev-size: calculate sizes of repository
Date: Sun, 20 Aug 2006 12:54:52 +0200
Organization: M38c
Message-ID: <20060820105452.GA19630@nospam.com>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
X-From: git-owner@vger.kernel.org Sun Aug 20 12:55:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEkxJ-0004lb-08
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 12:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWHTKy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 06:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWHTKy5
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 06:54:57 -0400
Received: from post-24.mail.nl.demon.net ([194.159.73.194]:27619 "EHLO
	post-24.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750733AbWHTKy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 06:54:56 -0400
Received: from wingding.demon.nl ([82.161.27.36]:42198)
	by post-24.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GEkxD-000HcG-Cy
	for git@vger.kernel.org; Sun, 20 Aug 2006 10:54:55 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1GEkxA-0006yH-Ig
	for git@vger.kernel.org; Sun, 20 Aug 2006 12:54:52 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25748>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Just created as answer to a request on IRC: a script to get the sizes
of a repository and various stages. It caches all sizes it finds, so
is quite fast once it has ramped up.

Example on git repo:

$ git-rev-size.rb HEAD~10..HEAD
ef75951ecabd53b5ed816eb596992f8d222d0fe3 21 694 3343495
a625daccb1750c56768481ec9a5dfd4f9053774e 21 694 3343492
55c3eb434ab6d489c632263239be15a1054df7f2 21 694 3343481
a89fccd28197fa179828c8596791ff16e2268d20 21 694 3343523
d4baf9eaf47ea1ba204f1ab5ecd22326913dd081 21 694 3343498
409d1d2053657f73a3222651111740606122aa80 21 694 3343423
076a10c7282a08f783a28c1b64d0e114a3fe3d39 21 694 3342501
8e3abd4c97b8e7e1128ad0cc44dcc267f478659a 21 694 3342485
500a99935dc157a6625b4decae0b97e896061c2c 21 692 3334754
6493cc09c2aa626ffbe6024dd705e1495c2d87e4 21 692 3334511
d78b0f3d6aa04510dd0c22c3853d3954c5f5b531 21 688 3322774
0fc82cff12a887c1e0e7e69937dbd8a82843c081 21 694 3343352
42f774063db1442fc3815f596d263f90dcd8380b 21 694 3344828
520cd3eca5743bebd217423e1fd0721f32613bb1 21 693 3344115
789a09b4874ae2616987794e0e739b8227957175 21 692 3335517
c35f4c371ac12f4d29b08e46c519ddc0a6494f6e 21 691 3330286


Numbers are SHA1 hash, number of trees, number of blobs and total
number of bytes in those blobs.

You can also find it on http://www.wingding.demon.nl/git-rev-size.rb

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-rev-size.rb"

#!/usr/bin/env ruby

# Calculates sizes of repository at different commits in git
#
# 20060819 Initial release
# 20060820 Pass arguments to git-rev-list
#
# (c)2006 R. Nijlunsing <git@tux.tmfweb.nl>
# License: LGPLv2

require 'set'
require 'enumerator'

if ARGV.empty?
  puts "Calculates sizes of repository at different commits"
  puts
  puts "Usage: #{$0} <arguments for git-rev-list>"
  puts "Example: #{$0} HEAD"
  exit 1
end

class Sizes
  attr_reader :trees, :blobs, :bytes
  def initialize(trees, blobs, bytes); @trees = trees; @blobs = blobs; @bytes = bytes; end
  def add(o); @trees += o.trees; @blobs += o.blobs; @bytes += o.bytes; end
end

def tree_size(tree)
  return $sha2size[tree] if $sha2size.include?(tree)
  size = Sizes.new(1, 0, 0)
  blobs = []			# Blobs with unknown sizes
  File.popen("git cat-file -p #{tree}", "r") { |io|
    while line = io.gets
      line =~ %r{^[0-9]{6} ([a-z]+) ([0-9a-f]+)}
      type, sha1 = $1, $2
      if $sha2size.include?(sha1)
        size.add($sha2size[sha1])
      elsif type == "tree"
	size.add(tree_size(sha1))
      elsif type == "blob"
	blobs << sha1
      else
        raise type
      end
    end
  }
  if blobs.size > 0
    # Do all _blobs_ at once. For this to help, git-cat-file should accept
    # more than one filename a time.
    blobs.each_slice(1) { |blobs_slice|
      File.popen("git cat-file -s #{blobs_slice.join(' ')}", "r") { |io|
        blobs_slice.each { |blob|
          blob_size = $sha2size[blob] = Sizes.new(0, 1, io.gets.to_i)
	  size.add(blob_size)
        }
      }
    }
  end
  $sha2size[tree] = size
end

$sha2size = {}			# SHA1 -> Sizes

File.popen("git rev-list #{ARGV.join(' ')}", "r") do |cio|
  while commit = cio.gets
    tree = nil			# Root tree of this commit
    commit = commit.chomp
    File.popen("git cat-file -p #{commit}", "r") do |io|
      while (line = io.gets) && !tree
        tree = $1 if line =~ %r{^tree ([a-f0-9]+)}
      end
    end
    if tree
      sizes = tree_size(tree)
      puts "#{commit} #{sizes.trees} #{sizes.blobs} #{sizes.bytes}"
    end
  end
end

--PNTmBPCT7hxwcZjr--
