From: Jan Hudec <bulb@ucw.cz>
Subject: [RFC] Common library for Git GUIs
Date: Mon, 16 Feb 2009 22:24:59 +0100
Message-ID: <20090216212459.GA25046@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonas Fonseca <fonseca@diku.dk>,
	Marco Costalba <mcostalba@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Abhijit Bhopatkar <bain@devslashzero.com>,
	Henk <henk_westhuis@hotmail.com>, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 22:41:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBDG-0006fH-3N
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbZBPVjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZBPVjq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:39:46 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:56548 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbZBPVjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:39:45 -0500
X-Greylist: delayed 882 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Feb 2009 16:39:44 EST
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by mail.bluetone.cz (Spam Firewall) with ESMTP
	id 9B18826C05E; Mon, 16 Feb 2009 22:24:59 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by mail.bluetone.cz with ESMTP id JL7LtOD9kjWtrab8; Mon, 16 Feb 2009 22:24:59 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1LZAxX-0006uZ-B2; Mon, 16 Feb 2009 22:24:59 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110246>

Hello Folks,

Sorry for a long mail. I am CC'ing people who wrote some git guis; I hope
it does not offend you.

Looking at the current situation with Git GUIs, I thought it might be useful
to create a generic library that would make it easier to develop git guis
(especially plugins to various tools) and to add a new features to many of
them with less effort. What do you people think about such idea?

Unfortunately in current situation no gui really supports all I would need to
get my colleagues at work to accept git (they are somewhat obsessed with
plugin to Visual Studio and explorer and generally avoiding command line).
I started working on VS plugin some time ago, but I feel like a bit more
reuse would be in order.

The proposed library should contain:

 - Models for the most common data GUIs want to display

   All modern GUI libraries (Qt, Gtk, WinForms, Cocoa) have some kind of
   generic interface for obtaining list, textbox and perhaps editbox data.
   Morover, the interfaces are pretty similar, so it should possible to
   create one interface and adapt it for the remaining toolkits.

   Data we want to export like this are:

    - Tree of all files in the work area with their status
      Seeing status (unchanged/modified/staged/new/...) of individual files
      in Visual Studio is the most wanted features of my colleagues at $work.
      The feature is applicable for Windows shell extension (Tortoise Git),
      similar KDE and Gnome extensions and all IDE bindings.

    - Tree of files in given revision
      For browsing other revisions than the checked out one.

    - History *tree*
      Starting gitk as separate process is suboptimal, because versions from
      the tree can't be easily selected for operations (checkout, merge, ...).

    - Blob data
      For looking at other revisions than the checked out one.

    - Commit properties
      For showing details of revisions in the history view.

    - Diffs
      Obviously...

    - Annotations
      Again, should be integrated with the rest of gui, so selecting line in
      annotation can open the revision in diff view, select it in history
      etc.

    - Configuration
      Many tools (eg. gui designers) feature a tree view of all properties of
      some object (property grid) with editable values and short
      descriptions. It's not as nice gui designed for individual options, but
      can provide good-enough easy-to-write way to set all valid options from
      the gui.

    Quite likely you can think of more data. Having generic implementation
    would save some coding when implementing the various plugins and have the
    benefit that additional view could be easily added to other guis, when
    it's implemented for one, because the interfaces will be the same.

 - Menu and action definitions for the common operations

   At least Gtk and Qt (don't know about others) have a concept of Action,
   which combines function for executing some operation with icon, name and
   enabled status of that action. These are than used for general menu
   descriptions.

   A generic library could provide arrays of such actions, that would define
   generic context menus for many things. For file, all Guis probably want to
   be able to add, revert, diff and annotate it. For revisions, all Guis
   probably want to check it out, merge it or rebase on it. Ditto for branch,
   which can additionally be pushed and updated from remote etc. Most of
   these operations take no or one additional parameter or few defined types
   (revision, branch, file). So if we extend the Action concept a bit, adding
   support for new simple operations (stash, submodule operations, etc.)
   quite easy for the Guis.

   Also Git Gui supports defining such operations that run specified shell
   commands. Qgit has similar, slightly more limited feature. Defining it in
   reusable library would make allow once defined command show in all guis
   a user uses.

What it should use:

 - It should probably be in C++ or C, with bindings for at least Perl,
   Python, Ruby, C#(CLR) and Java. The bindings can be done either with Swig,
   or using some base library that already has them.

   I think Java or CLR, while more portable, would not be appropriate because
   there is no standard way to combine them with other languages like Perl,
   Python and Ruby and those languages are still superior for the UI
   programming itself. I somewhat prefer C++, because polymorphism and some
   template tools would be useful here, but I am open to arguments.

 - It needs a portable runtime supporting at least:
    - Starting processes. We need to run git and shell commands. Even when
      libgit2 is implemented and this library ported to it, ability to run
      external commands should remain and libgit2 is not usable yet anyway.
      Should include ability to properly quote and dequote command lines in
      Windows.
    - Event loop. We should be able to process git output asynchronously.
    - Threads. Not all guis will be able to integrate the event loop in their
      own, so we need ability to run the event loop in a thread and run
      callbacks there (which can than wake the gui main loop).
    - Filesystem access.
   Also it would be very nice to have:
    - File alteration monitor. It would be very nice to notice changes in the
      work area automatically and both Linux and Windows have, although
      greatly incompatible, ways to get notifications for that, so it would
      be nice to be able to use that.
    - Bindings for languages. We can use Swig, but it has e.g. no support for
      callbacks, so having portable runtime with already existing bindings
      that support this would be an advantage.

Portable runtime options:

 So what do you people think would be best? I see several options:

 - QtCore

   Qt seems to be the most popular library among Git GUI writers and since
   version 4.5 will be LGPL, so it will be allowed to link with anything.
   It is also probably the most portable one. On the downside, it's rather
   large and it's language bindings are a bit worse (the garbage collector
   integration was a bit bad last time I looked).

 - Glib

   This is C based, so the core could be in plain C. It is also quite modular
   and has very good support for bindings to various languages. On the
   downside it's a bit less portable and less used among the existing guis.
   C would mean more work, but we could probably save some of it by using
   gob2 (g object builder)

 - STL + Boost

   I don't have experience with it, though I read some of the documentation.
   It should be sensibly portable. I know it has python bindings, the rest
   would probably have to be dealt with using swig.

 - POSIX + Msys on Windows

   I guess it would technically be usable, but I think it would be rather lot
   of additional work. It would probably be quite lightweight, though.

 - Apache portable runtime

   I have no experience with this one.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
