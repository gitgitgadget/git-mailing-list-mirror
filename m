From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make "repack -f" imply "pack-objects --no-reuse-object"
Date: Wed, 09 May 2007 12:59:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705091247450.24220@xanadu.home>
References: <4640FBDE.1000609@gmail.com>
 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
 <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
 <56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
 <alpine.LFD.0.99.0705091048120.24220@xanadu.home>
 <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 18:59:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlpW0-0001S6-2j
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbXEIQ7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbXEIQ7n
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:59:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30285 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbXEIQ7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:59:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHS00CGM9VGMHH0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 May 2007 12:59:41 -0400 (EDT)
In-reply-to: <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46752>

As Junio said:

  Recomputing delta is much more expensive than recompressing
  anyway, and when the user says 'repack -f', it is a sign that
  the user is willing to spend CPU cycles.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Wed, 9 May 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > What we need instead is a --no-reuse-object that would force 
> > recompression of everything when you really want to enforce a specific 
> > compression level across the whole pack(s).
> 
> Yeah.  Or maybe --no-reuse to mean both and make '-f' a
> short-hand synonym for that.
> 
> I do not see much reason to want to tweak them independently;
> recomputing delta is much more expensive than recompressing
> anyway, and when the user says 'repack -f', it is a sign that
> the user is willing to spend CPU cycles.

This applies on top of my --no-reuse-object patch.  I think it is good 
to have the flexibility in the plumbing, but as you say git-repack 
might as well use the strongest option.

diff --git a/git-repack.sh b/git-repack.sh
index ddfa8b4..8bf66a4 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -8,7 +8,7 @@ SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 no_update_info= all_into_one= remove_redundant=
-local= quiet= no_reuse_delta= extra=
+local= quiet= no_reuse= extra=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -16,7 +16,7 @@ do
 	-a)	all_into_one=t ;;
 	-d)	remove_redundant=t ;;
 	-q)	quiet=-q ;;
-	-f)	no_reuse_delta=--no-reuse-delta ;;
+	-f)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
 	--window=*) extra="$extra $1" ;;
 	--depth=*) extra="$extra $1" ;;
@@ -61,7 +61,7 @@ case ",$all_into_one," in
 	;;
 esac
 
-args="$args $local $quiet $no_reuse_delta$extra"
+args="$args $local $quiet $no_reuse$extra"
 name=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
 if [ -z "$name" ]; then
