From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v4 2/2] gitk: synchronize config write
Date: Mon, 2 Mar 2015 22:43:54 +0200
Message-ID: <20150302204354.GB7622@wheezy.local>
References: <1415571602-5858-1-git-send-email-max@max630.net>
 <1415571602-5858-3-git-send-email-max@max630.net>
 <20150302001050.GC24862@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:43:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSXC2-00052C-0p
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 21:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbbCBUny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 15:43:54 -0500
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:38626
	"EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751914AbbCBUnx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 15:43:53 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-07.prod.phx3.secureserver.net with 
	id ykjp1p00C5B68XE01kjsLY; Mon, 02 Mar 2015 13:43:53 -0700
Content-Disposition: inline
In-Reply-To: <20150302001050.GC24862@iris.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264624>

On Mon, Mar 02, 2015 at 11:10:51AM +1100, Paul Mackerras wrote:
> The idea looks good; I have a couple of comments on the patch.  First,
> 50 tries over 5 seconds seems a bit excessive to me, wouldn't (say) 20
> tries be enough?  Is the 50 the result of some analysis?

5 seconds was just my personal feeling where "too long" is
starting.

I have made some quick experiment: I opened ~10 instances
and closing them with group close in Windows 7. With 1
second wait it often can hit the error while closing several
instances at once. With 20 seemed to work reliably. Will
look a bit more though, maybe also handle the failing case
more nice, to avoid having leftover.

The interval of 100 milliseconds was also voluntary. Maybe
need to measure how long the saving actually takes.

> 
>> +	    error_popup "Probably there is stale $config_file_tmp file; config saving is going to fail. Check if it is being used by any existing gitk process and remove it otherwise"
> 
> I would word this as "There appears to be a stale $config_file_tmp
> file, which will prevent gitk from saving its configuration on exit.
> Please remove it if it is not being used by any existing gitk
> process."

ok, will change it

> > @@ -2811,11 +2824,16 @@ proc savestuff {w} {
> >  
> >      if {$stuffsaved} return
> >      if {![winfo viewable .]} return
> > +    set remove_tmp 0
> >      catch {
> > -	if {[file exists $config_file_tmp]} {
> > -	    file delete -force $config_file_tmp
> > +	set try_count 0
> > +	while {[catch {set f [open $config_file_tmp {WRONLY CREAT EXCL}]}]} {
> > +	    if {[incr try_count] > 50} {
> > +		error "Unable to write config file: $config_file_tmp exists"
> > +	    }
> > +	    after 100
> >  	}
> > -	set f [open $config_file_tmp w]
> > +	set remove_tmp 1
> >  	if {$::tcl_platform(platform) eq {windows}} {
> >  	    file attributes $config_file_tmp -hidden true
> >  	}
> > @@ -2878,6 +2896,14 @@ proc savestuff {w} {
> >  	puts $f "}"
> >  	close $f
> >  	file rename -force $config_file_tmp $config_file
> > +	set remove_tmp 0
> > +	return ""
> > +    } err
> > +    if {$err ne ""} {
> > +	puts "Error saving config: $err"
> 
> I would suggest checking the return from the catch statement, like
> this:
> ...
> rather than doing a return inside the catch.

Yes, I can make proper error handling. Then I think it would better be a separated patch.

-- 
Max
