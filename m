From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] Common library for Git GUIs
Date: Tue, 17 Feb 2009 21:39:42 +0100
Message-ID: <20090217203942.GB2216@efreet.light.src>
References: <20090216212459.GA25046@efreet.light.src> <8b65902a0902170455lda80ea3ybb8ca94eb86d0453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 21:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZWkk-0008EN-GH
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 21:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbZBQUjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 15:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbZBQUjp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 15:39:45 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:37845 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbZBQUjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 15:39:45 -0500
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by mail.bluetone.cz (Spam Firewall) with ESMTP
	id 6390029CD7F; Tue, 17 Feb 2009 21:39:42 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by mail.bluetone.cz with ESMTP id aq8NSCemlWHbVQCC; Tue, 17 Feb 2009 21:39:42 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1LZWjG-0001AI-12; Tue, 17 Feb 2009 21:39:42 +0100
Content-Disposition: inline
In-Reply-To: <8b65902a0902170455lda80ea3ybb8ca94eb86d0453@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110451>

On Tue, Feb 17, 2009 at 13:55:04 +0100, Guilhem Bonnefille wrote:
> I don't know if it is possible to elect a toolkit. Each toolkit is good.

Unfortunately this is quite important question. The selected foundation
needs to be very portable and fairly lightweight. Heavy dependency would
discourage gui implementors from using it.

Note, that I am *not* talking about GUI toolkit! The layer I am proposing
should be gui toolkit agnostic or mostly so. Consider a model-view-controller
design pattern. The goal is to provide generic model and controller parts in
one layer and adaptors to model interfaces (like QAbstractItemModel and
GtkTreeModel) in a set of thin layers for each gui toolkit.

Another set of thin layers could wrap them for various dynamic languages --
python, perl, ruby, C# (CLR) and Java, either using binding infrastructure of
the selected toolkit, or using Swig.

> Concerning the design of the library, I think it is better to split
> the library into different layers. The part of the e-world I know
> concern Gtk/Gnome, so I will use it for my example.
> 
> IMHO, it should be interesting to build a library containing only
> GObject'ification of Git and some wrappers/helpers to construct these
> objects. For example, some objects to represent authors, commits,
> branches, remotes and so on. Coupled to these base-types, this library
> should provide solutions to construct these base-types (wrappers
> around Git commands and/or internal files).
> This library can be named libgit-glib for example.
> Such library can help developement of current UI (giggle, gitg,
> anjuta-git plugin, and probably others I don't know).

Yes -- that's my idea. Basically it would be one layer for calling to git
program behind the scenes, parsing and caching the results and presenting
them in a form of genericish API.

Such API must not be too generic -- that would be just pointless wrapping one
interface in another. The API would be strongly tied to the GUI features --
e.g. an object holding all data a dialog for preparing commit needs. But it
must not be tied to any particular GUI, because that is usually restricted by
the environment one wants to integrate git with.

> Then, on top of this library, we can imagine another one providing
> high-level widgets. But it seems harder to identify common widgets
> between different GUI.

Actually it is quite possible. There is a rather restricted set of
primitives:
 - button (also toolbar button and simple menu item)
 - choice (toggle button, check button, radio button group, combo box)
 - entry (entry, label (read-only entry))
   - number entry (spinbutton, slider, scrollbar)
   - text edit (for longer texts)
 - multi-column tree

For each of these primitives, you can create a generic interface:
 - button:

   This is a method to be executed on the button activation. It might be
   accompanied by name of the action, it's icon and a flag whether it should
   be enabled.

   Gtk has GtkAction and Qt has QAction, that do just this. We can easily
   create simple object with the same properties and adapt it to both of
   these and any similar interface used by any other toolkit.

 - choice:

   This is a variable with current value, that can be read and written and an
   array of valid choices. Some kind of signal must be emited when the value
   is changed, either by gui or by underlying application logic.

   I don't think there is a generic interface for this in either Gtk or Qt,
   but a generic one can be written and connections to the relevant widgets
   would than be generic for each toolkit.

 - entry:

   This is just a variable with current value, that can be read and written.
   Again, I don't think there is generic interface in Gtk or Qt, but one can
   be written and the connections would than be generic.

 - number entry:

   This is again a variable with current value, this time accompanied by
   minimum, maximum, precision and possibly page size. Adaptation can be done
   generically again.

   I am not sure we actually need this. The only I can think of is some
   numerical configuration options (like gc.reflogexpire) and that might not
   be worth the hassle. Definitely for the earlier versions.

 - text entry:

   Gtk has GtkTextBuffer, but Qt does not seem to have anything similar and
   to tell the truth I don't think we need either. We simply provide the
   initial text and get fed the final from the widget.
   
   Simple interface would be like for entry, where we provide the intial text
   and get fed the final one.

   Advanced interface needs to additionally support handling selection, so we
   can support things like selecting hunks in a diff.

 - multi-column tree:

   This is the most complex thing. It provides a tree of items, each of them
   consisting of several columns. Each column may additionally be editable,
   so it may need to be necessary to create one of the simple interfaces for
   it. Selection handling, at least single-line, would also be needed.

   For Gtk this would implement the GtkTreeModel and for Qt the
   QAbstractItemModel. All modern widget toolkits (Gtk, Qt, Windows.Forms,
   Cocoa, ...) have some kind of interface like that and they will be similar
   enough so that we can create some and than generically implement the rest
   in terms of that.

This is where I'd stop, since everything above that is very much specific to
the selected toolkit. However, if layer like this is done right, it can
really simplify creating the GUI itself quite a lot.

> In order to justify my idea, take a look at Qt. They started with a
> large library, merging low-level with widgets. And then, they split it
> in order to allow access to low-level features only.
> 
> I'm really interested in such project. So, if someone knows such
> project, or create such a project, drop me a line, please.

I am not aware of it existing. I was playing with an idea of refactoring some
of the existing GUIs to get a generic library out of it. Mainly because I am
not really satisfied with any of them and I thought such refactoring would
simplify adding new features.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
