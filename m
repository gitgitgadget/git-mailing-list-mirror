From: Pavel Roskin <proski@gnu.org>
Subject: Some issues with current qgit on exit
Date: Tue, 05 Sep 2006 18:00:50 -0400
Message-ID: <1157493650.2803.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 00:01:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKiya-0001k5-Bp
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 00:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWIEWA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWIEWA5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 18:00:57 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10423 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965159AbWIEWAz
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 18:00:55 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GKiyU-00042j-13
	for git@vger.kernel.org; Tue, 05 Sep 2006 18:00:54 -0400
Received: from proski by dv.roinet.com with local (Exim 4.63)
	(envelope-from <proski@dv.roinet.com>)
	id 1GKiyQ-0000pZ-EL; Tue, 05 Sep 2006 18:00:50 -0400
To: Marco Costalba <mcostalba@gmail.com>
X-Mailer: Evolution 2.7.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26492>

Hi, Marco!

The current qgit reports assertion failure on exit:
ASSERT in tabWdg_currentChanged

That's how you can trigger it:

select one of the patches
double click on the entry to open the "patch" tab
double click on one of the modified files on the right
switch back to the "rev list" or "patch" tab
close qgit by Ctrl-Q

I've tried to debug the problem.  MainImpl::currentTabType() returns -1.
It's possible that the logic in that function is flawed, or maybe it
doesn't work properly on exit.

Another problem is segmentation fault when closing qgit with more that
one file tab and the "rev list" tab selected:

select one of the patches
select "view file" in the pop-up menu on one of the files
activate the "rev list" tab
select "view file in new tab" on the same file
activate the "rev list" tab
close qgit by Ctrl-Q

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 46998824734480 (LWP 3112)]
0x0000001400040038 in ?? ()
(gdb) where
#0  0x0000001400040038 in ?? ()
#1  0x000000000046c336 in MainImpl::tabWdg_currentChanged (this=0x794490, w=0x12098d0)
    at mainimpl.cpp:788
#2  0x000000000048b33b in MainBase::qt_invoke (this=0x794490, _id=93, _o=0x7fffe87794a0)
    at mainbase.moc.cc:240
#3  0x0000000000497f19 in MainImpl::qt_invoke (this=0x794490, _id=93, _o=0x7fffe87794a0)
    at mainimpl.moc.cc:350
#4  0x00002abec28a8929 in QObject::activate_signal () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#5  0x00002abec2bf77e4 in QTabWidget::currentChanged ()
   from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#6  0x00002abec2bf7741 in QTabWidget::qt_invoke () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#7  0x00002abec28a8929 in QObject::activate_signal () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#8  0x00002abec28a9578 in QObject::activate_signal () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#9  0x00002abec29cd85d in QTabBar::setTabEnabled () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#10 0x00002abec29d0bde in QTabWidget::removePage () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#11 0x00002abec29cffcc in QTabWidget::eventFilter () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#12 0x00002abec28a7fc2 in QObject::activate_filters () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#13 0x00002abec28a8037 in QObject::event () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#14 0x00002abec28dfaf8 in QWidget::event () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#15 0x00002abec2847da5 in QApplication::internalNotify ()
   from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#16 0x00002abec2849274 in QApplication::notify () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#17 0x00002abec28a97b8 in QObject::removeChild () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#18 0x00002abec28aa898 in QObject::~QObject$base () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#19 0x00002abec28e2720 in QWidget::~QWidget$base () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#20 0x00000000004a8a91 in ~TabFile (this=0xac9e40) at filebase.uic.cc:513
#21 0x0000000000440b14 in ~FileView (this=0xac9b80) at fileview.cpp:99
#22 0x00002abec28a8089 in QObject::event () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#23 0x00002abec2847da5 in QApplication::internalNotify ()
#24 0x00002abec2849274 in QApplication::notify () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#25 0x00002abec2848da9 in QApplication::sendPostedEvents ()
   from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#26 0x00002abec285f5fa in QEventLoop::enterLoop () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#27 0x00002abec285f442 in QEventLoop::exec () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#28 0x000000000047d134 in main (argc=1, argv=0x7fffe8779df8) at qgit.cpp:17


All this is observed on the current development Fedora Core 6 with Qt 
3.3.6 and gcc 4.1.1, architecture is x86_64.

-- 
Regards,
Pavel Roskin
