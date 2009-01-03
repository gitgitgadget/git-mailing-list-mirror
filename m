From: david@lang.hm
Subject: Re: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 20:25:58 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901022020410.21567@asgard.lang.hm>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm> <20090102212655.GA24082@coredump.intra.peff.net> <alpine.DEB.1.10.0901021459480.21567@asgard.lang.hm> <alpine.DEB.1.10.0901021544580.21567@asgard.lang.hm>
 <alpine.DEB.1.10.0901021554581.21567@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 03 04:25:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIx8P-00070Z-W9
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 04:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758832AbZACDXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 22:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758773AbZACDXm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 22:23:42 -0500
Received: from mail.lang.hm ([64.81.33.126]:56534 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758790AbZACDXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 22:23:41 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n033NaOk025139;
	Fri, 2 Jan 2009 19:23:36 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.10.0901021554581.21567@asgard.lang.hm>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104452>

On Fri, 2 Jan 2009, david@lang.hm wrote:

> On Fri, 2 Jan 2009, david@lang.hm wrote:
>
>> On Fri, 2 Jan 2009, david@lang.hm wrote:
>> 
>>> On Fri, 2 Jan 2009, Jeff King wrote:
>>> 
>>>> The tricky thing here is what is "this line"? Using the line number
>>>> isn't right, since it will change based on other content coming in and
>>>> out of the file. You can keep drilling down by reblaming parent commits,
>>>> but remember that each time you do that you are manually looking at the
>>>> content and saying "Oh, this is the line I am still interested in." So I
>>>> a script would have to correlate the old version and new version of the
>>>> line and realize how to follow the "interesting" thing.
>>>> 
>>>> In your case, I think you want to see any commit in Makefile which
>>>> changed a line with SUBLEVEL in it. Which is maybe easiest done as:
>>>>
>>>>  git log -z -p Makefile |
>>>>    perl -0ne 'print if /\n[+-]SUBLEVEL/' |
>>>>    tr '\0' '\n'
>>>> 
>>>> and is pretty fast. But obviously we're leveraging some content-specific
>>>> knowledge about what's in the Makefile.
>>> 
>>> Ok, I hacked togeather a quick bash script to try this
>>> 
>> <SNIP>
>>> the problem that this has is that line 3 of $COMMIT may not be line 3 of 
>>> $COMMIT^, and if they aren't it ends up hunting down the wrong data

solving this problem was a bit more work than expected. I ended up 
invoking git diff to do the step back and find what lines were replaced by 
the one I care about.

this still can run into problems if the lines that are examined are not 
unique (git blame only finds the first match)



#!/usr/bin/perl
# program to trace the history of a line through a git repository
#
# useage findlines pattern filespec
#
# finds all occurances of the pattern in the file and then uses git blame
#  to find where those lines were introduced. It then takes a step back 
and
#  looks at what the line replaced (if anything) and does a git blame on 
those
#  lines as well
#
# written by David Lang and released under GPLv2
#
$target = shift @ARGV;
$file = shift @ARGV;
open($infile,"<$file");
$linecount=0;
# find all lines in the file that match the target pattern
# we have been provided. add them to a stack of items to research
while(<$infile>){
   $linecount++;
   if ($_ =~ /$target/) {
     $items[++$#items]{line} = $linecount;
     $items[$#items]{tree} = "HEAD";
     chomp;
     $items[$#items]{target} = $_;
   }
}
# go through all the items and research them in turn
#  (note that more items may be added to the list while inside this loop)
for ($i=0;$i<=$#items;$i++) {
# do a git blame to find where the lines came from
   $result = `git blame -b -l -L "$items[$i]{line}",+1 -M  $file 
$items[$i]{tree}` ;
   print "in ".$items[$i]{tree}." found:\n$result";
   $commit=substr($result,0,40);
   # if this is not the root commit,
   #  do a diff to find what lines may have been replaced by the line we 
are looking for
   if($commit ne "                                        "){
     $diff=`git diff -U0 $commit^..$commit $file`;
     @lines=split("\n",$diff);
     #strip the first four lines from the diff (as they just talk about the 
file)
     shift(@lines);
     shift(@lines);
     shift(@lines);
     shift(@lines);
     $match=0;
     $hunk='';
     # find what hunk of the diff introduced the lines we are looking for,
     #  add the lines that they replaced to the list of items to examine
     foreach(@lines){
       if ($_ =~ /^\@\@/ ) {
         if ($match) {
           process_hunk();
         } else {
           $hunk = '';
         };
       } else {
         $hunk .= $_."\n";
         if ($_ =~ /$items[$i]{target}/) {
           $match = 1;
         }
       }
     }
     if ($match) {
       process_hunk();
     }
   }
}
sub process_hunk(){
   # find lines in the hunk of diff that are being replaced
   foreach (split("\n",$hunk)){
     if ($_ =~ /^-/ ){
       # for now queue the line contents for further processing.
       #   this really should be the line number becouse otherwise
       #   git blame will use the first match it finds. since we are
       # matching the entire line this is less of a problem than it could 
be.
       $items[++$#items]{line} = "/".substr($_,1)."/";
       $items[$#items]{target} = substr($_,1);
       $items[$#items]{tree} = "$commit^";
     }
   }
}
