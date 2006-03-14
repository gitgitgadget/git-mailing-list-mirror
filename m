From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: Fix up diffcore-rename scoring
Date: Tue, 14 Mar 2006 01:49:39 +0100
Organization: M38c
Message-ID: <20060314004939.GA26674@nospam.com>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org> <7vmzfusuyq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603122256550.3618@g5.osdl.org> <Pine.LNX.4.64.0603122316160.3618@g5.osdl.org> <7vzmjupqv0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603130727350.3618@g5.osdl.org>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 01:49:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIxjQ-00040v-Sx
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 01:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWCNAtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 19:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWCNAtp
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 19:49:45 -0500
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:65233 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1751767AbWCNAto (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 19:49:44 -0500
Received: from wingding.demon.nl ([82.161.27.36]:42107)
	by post-25.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FIxjH-000D20-R7; Tue, 14 Mar 2006 00:49:41 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FIxjH-0000T3-CR; Tue, 14 Mar 2006 01:49:39 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603130727350.3618@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17581>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Rutger Nijlunsing <rutger@nospam.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Bcc: 
Subject: Re: Fix up diffcore-rename scoring
Reply-To: git@wingding.demon.nl
In-Reply-To: <Pine.LNX.4.64.0603130727350.3618@g5.osdl.org>
Organization: M38c

On Mon, Mar 13, 2006 at 07:38:53AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 13 Mar 2006, Junio C Hamano wrote:
> > 
> > By the way, the reason the diffcore-delta code in "next" does
> > not do every-eight-bytes hash on the source material is to
> > somewhat alleviate the problem that comes from not detecting
> > copying of consecutive byte ranges.
> 
> Yes. However, there are better ways to do that in practice.
> 
> The most effective way that is generally used is to not use a fixed 
> chunk-size, but use a terminating character, together with a 
> minimum/maximum chunksize.
> 
> There's a pretty natural terminating character that works well for 
> sources: '\n'.
> 
> So the natural way to do similarity detection when most of the code is 
> line-based is to do the hashing on chunks that follow the rule "minimum of 
> <n> bytes, maximum of <2*n> bytes, try to begin/end at a \n".
> 
> So if you don't see any '\n' at all (or the only such one is less than <n> 
> bytes into your current window), do the hash over a <2n>-byte chunk (this 
> takes care of binaries and/or long lines).
> 
> This - for source code - allows you to ignore trivial byte offset things, 
> because you have a character that is used for synchronization. So you 
> don't need to do hashing at every byte in both files - you end up doing 
> the hashing only at line boundaries in practice. And it still _works_ for 
> binary files, although you effectively need bigger identical chunk-sizes 
> to find similarities (for text-files, it finds similarities of size <n>, 
> for binaries the similarities need to effectively be of size 3*n, because 
> you chunk it up at ~2*n, and only generate the hash at certain offsets in 
> the source binary).

This looks like something I did last year as an experiment in the
pre-git times. The idea was to generate a patch-with-renames from two
(large) source trees.

Algorithm:
  - determine md5sum for each file (same idea as git's SHA1 sum)
    if changed since last run
  - only look at md5sums which do not match
  - pool files into types, which might depend on extension and/or MIME type.
    This is an optimisation.
  - Only compare filepair _within_ one pool.
  - The filepair order in one pool is determined by filename-similarity.
    So pair [include/asm-ppc/ioctl.h, include/asm-powerpc/ioctl.h]
    is inspected before pair
       [include/asm-ppc/ioctl.h, arch/arm/plat-omap/clock.h] .
  - For each file, create a hash from String line -> Integer occuranced .
    Similarities are calculated by comparing two hashes.
  - Keep as a rename-match all files which:
    - have at most 50% new lines;
    - have at most 25% lines deleted from them.

I ran the code against v2.6.12 and v2.6.14 to be able to compare it
with the current contenders. Hopefully some ideas are harvestable...

Algorithm differences:
  - '\n' is used as boundary, independant on line length.
    This is bad for binary files, and maybe even bad for text files.
    So don't harvest :)
  - don't look at the intersection percentage, but look at two values:
    - percentage of lines added (default: max. 50%)
    - percentage of lines removed (default: max. 25%)
    This assumes files get bigger during development (at most 50%), and
    not too much code is deleted (at most 25%).
    Disadvantages:
      - Two magic numbers instead of one.
      - It's non-symmetrical. Diff A->B will find different renames from
        diff B->A. This scares me, actually.
  - to speed up the detection:
    - don't start comparing files at random. Start comparing files which
      have the same 'names' in it. So when v2.6.12 has a files called
      arch/arm/mach-omap/clock.c, start comparing with files which have
      most words the same. Currently, '-', '.', '_' and '/' are used
      as word separators.
      Advantage: don't match on the first match just above the
        match-threshold.
    (next heuristics are all optional:)
    - only compare files with the same extension. This splits up all files
      into groups, which makes it much faster.
      In general, there's no reason to compare a .h with a .c file.
    - only compare files with the same MIME type. Same as above, but also
      works for files without extensions (so don't compare README with
      Makefile)

Ok, the result:

$ shpatch.rb -d linux-2.6.12,linux-2.6.14 | wc -l
104   <-- That's bad. We're missing some renames here.

$ shpatch.rb -d linux-2.6.12,linux-2.6.14 | sort -k 1.10

+ 0% -23% arch/arm/configs/omnimeter_defconfig -> arch/arm/configs/collie_defconfig
+ 5% - 9% arch/arm/mach-omap/board-generic.c -> arch/arm/mach-omap1/board-generic.c
+ 0% - 8% arch/arm/mach-omap/board-h2.c -> arch/arm/mach-omap1/board-h2.c
+ 0% - 5% arch/arm/mach-omap/board-h3.c -> arch/arm/mach-omap1/board-h3.c
+ 0% - 3% arch/arm/mach-omap/board-innovator.c -> arch/arm/mach-omap1/board-innovator.c
+ 0% - 9% arch/arm/mach-omap/board-netstar.c -> arch/arm/mach-omap1/board-netstar.c
+ 9% -10% arch/arm/mach-omap/board-osk.c -> arch/arm/mach-omap1/board-osk.c
+ 0% - 6% arch/arm/mach-omap/board-perseus2.c -> arch/arm/mach-omap1/board-perseus2.c
+ 3% - 8% arch/arm/mach-omap/board-voiceblue.c -> arch/arm/mach-omap1/board-voiceblue.c
+ 7% - 4% arch/arm/mach-omap/clock.c -> arch/arm/plat-omap/clock.c
+ 0% - 0% arch/arm/mach-omap/clock.h -> arch/arm/plat-omap/clock.h
+ 0% - 5% arch/arm/mach-omap/common.h -> include/asm-arm/arch-omap/common.h
+ 2% - 1% arch/arm/mach-omap/dma.c -> arch/arm/plat-omap/dma.c
+ 0% - 1% arch/arm/mach-omap/fpga.c -> arch/arm/mach-omap1/fpga.c
+11% -11% arch/arm/mach-omap/gpio.c -> arch/arm/plat-omap/gpio.c
+ 2% - 2% arch/arm/mach-omap/irq.c -> arch/arm/mach-omap1/irq.c
+ 0% - 4% arch/arm/mach-omap/leds.c -> arch/arm/mach-omap1/leds.c
+ 0% - 0% arch/arm/mach-omap/leds-h2p2-debug.c -> arch/arm/mach-omap1/leds-h2p2-debug.c
+ 0% - 0% arch/arm/mach-omap/leds-innovator.c -> arch/arm/mach-omap1/leds-innovator.c
+ 0% - 4% arch/arm/mach-omap/leds-osk.c -> arch/arm/mach-omap1/leds-osk.c
+ 0% -25% arch/arm/mach-omap/Makefile.boot -> arch/arm/mach-omap1/Makefile.boot
+ 1% - 2% arch/arm/mach-omap/mcbsp.c -> arch/arm/plat-omap/mcbsp.c
+ 0% - 6% arch/arm/mach-omap/mux.c -> arch/arm/plat-omap/mux.c
+ 0% - 0% arch/arm/mach-omap/ocpi.c -> arch/arm/plat-omap/ocpi.c
+ 1% -18% arch/arm/mach-omap/pm.c -> arch/arm/plat-omap/pm.c
+ 0% -11% arch/arm/mach-omap/sleep.S -> arch/arm/plat-omap/sleep.S
+ 6% - 4% arch/arm/mach-omap/time.c -> arch/arm/mach-omap1/time.c
+ 0% - 1% arch/arm/mach-omap/usb.c -> arch/arm/plat-omap/usb.c
+ 2% - 1% arch/ia64/sn/include/pci/pcibr_provider.h -> include/asm-ia64/sn/pcibr_provider.h
+ 0% - 2% arch/ia64/sn/include/pci/pic.h -> include/asm-ia64/sn/pic.h
+ 0% - 0% arch/ia64/sn/include/pci/tiocp.h -> include/asm-ia64/sn/tiocp.h
+ 3% -23% arch/m68knommu/platform/68VZ328/de2/config.c -> arch/m68knommu/platform/68VZ328/config.c
+ 1% -18% arch/mips/configs/osprey_defconfig -> arch/mips/configs/qemu_defconfig
+ 0% -12% arch/mips/vr41xx/zao-capcella/setup.c -> arch/mips/vr41xx/common/type.c
+ 0% - 0% arch/ppc64/oprofile/op_impl.h -> include/asm-ppc64/oprofile_impl.h
+ 3% -23% arch/ppc/configs/ash_defconfig -> arch/ppc64/configs/bpa_defconfig
+ 2% -21% arch/ppc/configs/beech_defconfig -> arch/ppc/configs/ev64360_defconfig
+ 5% -20% arch/ppc/configs/cedar_defconfig -> arch/ppc/configs/mpc8548_cds_defconfig
+ 9% -17% arch/ppc/configs/k2_defconfig -> arch/ppc/configs/bamboo_defconfig
+ 3% -25% arch/ppc/configs/mcpn765_defconfig -> arch/xtensa/configs/common_defconfig
+ 2% -23% arch/ppc/configs/oak_defconfig -> arch/frv/defconfig
+ 3% -16% arch/ppc/configs/SM850_defconfig -> arch/ppc/configs/mpc86x_ads_defconfig
+ 3% -13% arch/ppc/configs/SPD823TS_defconfig -> arch/ppc/configs/mpc885ads_defconfig
+19% -15% arch/um/kernel/tempfile.c -> arch/um/os-Linux/mem.c
+ 0% - 5% arch/x86_64/kernel/semaphore.c -> lib/semaphore-sleepers.c
+ 0% - 6% drivers/i2c/chips/adm1021.c -> drivers/hwmon/adm1021.c
+ 0% - 4% drivers/i2c/chips/adm1025.c -> drivers/hwmon/adm1025.c
+ 0% -17% drivers/i2c/chips/adm1026.c -> drivers/hwmon/adm1026.c
+ 0% - 3% drivers/i2c/chips/adm1031.c -> drivers/hwmon/adm1031.c
+ 0% - 4% drivers/i2c/chips/asb100.c -> drivers/hwmon/asb100.c
+ 1% - 4% drivers/i2c/chips/ds1621.c -> drivers/hwmon/ds1621.c
+ 0% - 1% drivers/i2c/chips/fscher.c -> drivers/hwmon/fscher.c
+ 0% - 2% drivers/i2c/chips/fscpos.c -> drivers/hwmon/fscpos.c
+ 0% - 2% drivers/i2c/chips/gl518sm.c -> drivers/hwmon/gl518sm.c
+ 0% - 2% drivers/i2c/chips/gl520sm.c -> drivers/hwmon/gl520sm.c
+ 3% -19% drivers/i2c/chips/it87.c -> drivers/hwmon/it87.c
+ 4% -22% drivers/i2c/chips/lm63.c -> drivers/hwmon/lm63.c
+ 0% - 6% drivers/i2c/chips/lm75.c -> drivers/hwmon/lm75.c
+ 0% - 2% drivers/i2c/chips/lm75.h -> drivers/hwmon/lm75.h
+ 0% - 3% drivers/i2c/chips/lm77.c -> drivers/hwmon/lm77.c
+ 2% - 5% drivers/i2c/chips/lm78.c -> drivers/hwmon/lm78.c
+ 0% - 3% drivers/i2c/chips/lm80.c -> drivers/hwmon/lm80.c
+ 2% -21% drivers/i2c/chips/lm83.c -> drivers/hwmon/lm83.c
+ 0% - 3% drivers/i2c/chips/lm85.c -> drivers/hwmon/lm85.c
+ 0% - 4% drivers/i2c/chips/lm87.c -> drivers/hwmon/lm87.c
+ 4% -20% drivers/i2c/chips/lm90.c -> drivers/hwmon/lm90.c
+ 0% - 3% drivers/i2c/chips/lm92.c -> drivers/hwmon/lm92.c
+ 0% - 3% drivers/i2c/chips/max1619.c -> drivers/hwmon/max1619.c
+ 0% - 7% drivers/i2c/chips/sis5595.c -> drivers/hwmon/sis5595.c
+ 0% -11% drivers/i2c/chips/smsc47b397.c -> drivers/hwmon/smsc47b397.c
+ 0% - 9% drivers/i2c/chips/smsc47m1.c -> drivers/hwmon/smsc47m1.c
+ 0% -23% drivers/i2c/chips/via686a.c -> drivers/hwmon/via686a.c
+ 0% - 4% drivers/i2c/chips/w83627hf.c -> drivers/hwmon/w83627hf.c
+ 1% - 5% drivers/i2c/chips/w83781d.c -> drivers/hwmon/w83781d.c
+ 1% - 3% drivers/i2c/chips/w83l785ts.c -> drivers/hwmon/w83l785ts.c
+14% -17% drivers/i2c/i2c-sensor-vid.c -> drivers/hwmon/hwmon-vid.c
+ 0% - 0% drivers/infiniband/include/ib_cache.h -> include/rdma/ib_cache.h
+ 0% - 3% drivers/infiniband/include/ib_fmr_pool.h -> include/rdma/ib_fmr_pool.h
+ 9% - 7% drivers/infiniband/include/ib_mad.h -> include/rdma/ib_mad.h
+ 0% - 0% drivers/infiniband/include/ib_pack.h -> include/rdma/ib_pack.h
+ 1% - 6% drivers/infiniband/include/ib_sa.h -> include/rdma/ib_sa.h
+ 0% -11% drivers/infiniband/include/ib_smi.h -> include/rdma/ib_smi.h
+ 3% - 6% drivers/infiniband/include/ib_user_mad.h -> include/rdma/ib_user_mad.h
+ 4% - 2% drivers/infiniband/include/ib_verbs.h -> include/rdma/ib_verbs.h
+ 0% -16% include/asm-ppc64/ioctl.h -> include/asm-powerpc/ioctl.h
+ 0% - 9% include/asm-ppc64/ioctls.h -> include/asm-powerpc/ioctls.h
+ 5% - 9% include/asm-ppc64/mc146818rtc.h -> include/asm-powerpc/mc146818rtc.h
+ 0% - 5% include/asm-ppc64/mman.h -> include/asm-powerpc/mman.h
+ 2% -25% include/asm-ppc64/sembuf.h -> include/asm-powerpc/sembuf.h
+ 3% -13% include/asm-ppc64/shmbuf.h -> include/asm-powerpc/shmbuf.h
+ 0% -15% include/asm-ppc64/sockios.h -> include/asm-powerpc/sockios.h
+ 1% - 5% include/asm-ppc64/topology.h -> include/asm-powerpc/topology.h
+ 0% -15% include/asm-ppc64/user.h -> include/asm-powerpc/user.h
+ 0% -21% include/asm-ppc/agp.h -> include/asm-powerpc/agp.h
+12% -16% include/asm-ppc/msgbuf.h -> include/asm-xtensa/msgbuf.h
+ 5% -25% include/asm-ppc/namei.h -> include/asm-powerpc/namei.h
+ 4% -18% include/asm-ppc/param.h -> include/asm-powerpc/param.h
+ 0% -13% include/asm-ppc/poll.h -> include/asm-powerpc/poll.h
+ 0% -24% include/asm-ppc/shmbuf.h -> include/asm-xtensa/shmbuf.h
+ 1% -17% include/asm-ppc/socket.h -> include/asm-powerpc/socket.h
+ 0% - 9% include/asm-ppc/string.h -> include/asm-powerpc/string.h
+ 1% -10% include/asm-ppc/termbits.h -> include/asm-powerpc/termbits.h
+ 0% - 3% include/asm-ppc/termios.h -> include/asm-powerpc/termios.h
+ 5% -22% include/asm-ppc/unaligned.h -> include/asm-powerpc/unaligned.h

Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="shpatch.rb"

#!/usr/bin/env ruby

# Usage: shpatch.rb --help

require 'md5'
require 'ostruct'
require 'optparse'

$config = OpenStruct.new
$config.command = :PATCH
$config.same_base = false
$config.same_ext = true
$config.same_mime = false
$config.changed_content = true
$config.max_removed = 25	# 0 .. 100
$config.max_added = 50
$config.verbose = false

# Default dirglobs to ignore
ignore_globs = [
  "BitKeeper", "PENDING", "SCCS", "CVS", "*.state", "*.o", "*.a", "*.so",
  "*~", "#*#", "*.orig", "*.dll"
]

# Option parsing
$opts = OptionParser.new
$opts.banner = %Q{\
Generate a shellpatch file, or perform the patch in a shellpatch file.
A shellpatch file is a patch file which contains shell-commands
including 'mv' and 'patch'.

Determining the renames uses a lot of heuristics and a brute-force
approach; your milage may vary. All trivial file renames are handled
by comparing the complete contents. All remaining files (the list of
added and removed files) in then searched through to find matching
pairs: this is quite costly

A cache of md5 sums is kept at the root of the repositories to make
finding differences fast.

(c)2005 R. Nijlunsing <shpatch@tux.tmfweb.nl>
License: GPLv2

Usage: shpatch [options]

Defaults options are within [brackets].

}
$opts.separator("Diff options")
$opts.on("-d", "--diff PATH1,PATH2", Array,
  "Generate a shellpatch of the diff", "between two directories") {
  |paths|
  if paths.size != 2
    raise Exception.new("Need two directories for --diff")
  end
  $config.command = :DIFF
  $config.paths = paths
}
$opts.separator("Diff options for heuristics to finding renames with changed content")
$opts.on("--[no-]changed-content",
  "Find renames with changed content [#{$config.changed_content}]" ) { |cc|
  $config.changed_content = cc
}
$opts.on("--[no-]same-base",
  "Rename only to files with same basename [#{$config.same_base}]") { |sb|
  $config.same_base = sb
}
$opts.on("--[no-]same-ext",
  "Rename only to same extention [#{$config.same_ext}]") { |se|
  $config.same_ext = se
}
$opts.on("--[no-]same-mime",
	 "Rename only to same mimetype [#{$config.same_mime}]") { |sm|
  $config.same_mime = sm
}
$opts.on("--max-removed PERC", String,
  "Max. percentage of source file which may",
  "be removed while still being considered",
  "a rename [#{$config.max_removed}]"
) { |perc| $config.max_removed = perc.to_i }
$opts.on("--max-added PERC", String,
  "Max. percentage of destination file which may",
  "be added while still being considered",
  "a rename [#{$config.max_added}]"
) { |perc| $config.max_added = perc.to_i }
$opts.separator("Options to add to current patch")
$opts.on("--mv SOURCE DEST", String, String,
  "Adds a rename to the current patch", "and perform the rename") {
  |path1, path2|
  $config.command = :MV
  $config.paths = [path1, path2]
}
$opts.separator("General options")
$opts.on("--[no-]verbose", "-v", "Be more verbose") { |v| $config.verbose = v }
$opts.on("--help", "-h", "This usage") { puts $opts; exit 1 }
%Q{

Examples:
  shpatch.rb --diff linux-2.6.8,linux-2.6.9 --max-removed 10
    Generate a shellpatch with renames from directories
    linux-2.6.8 to linux-2.6.9 . At most 10% of a file may be removed
    between versions, otherwise they are considered different.
}.split("\n").each { |line| $opts.separator(line) }
begin
  $opts.parse!(ARGV)
rescue Exception
  puts "#{$opts}\n!!! #{$!}"
  exit 1
end

module Shell
  # Escape string string so that it is parsed to the string itself
  # E.g. Shell.escapeString("what's in a name") = "what\'s\ in\ a\ name"
  # Compare to Regexp.escape
  def Shell.escape(string)
    string.gsub(%r{([^-._0-9a-zA-Z/])}i, '\\\\\1')
  end
end

# One hunk in the patch
class RenameHunk
  attr_accessor :from, :to	# Strings: pathname from and to

  def initialize(from, to)
#    puts "# Found a rename: #{Shell.escape(from)} -> #{Shell.escape(to)}"
    @from = from; @to = to
  end
  def command; "mv"; end
  def to_s; "#{command} #{Shell.escape(@from)} #{Shell.escape(@to)}"; end
  def execute(repo)
    File.rename("#{repo.root}/#@from", "#{repo.root}/#@to")
  end
end

class DeleteHunk
  attr_accessor :pathname
  def initialize(pathname); @pathname = pathname; end
  def command; "rm"; end
  def to_s; "#{command} #{Shell.escape(@pathname)}"; end
  def execute(repo); File.delete("#{repo.root}/#@pathname"); end
end

class PatchHunk
  attr_accessor :from, :to, :contents
  def initialize(repo1, from, repo2, to)
    @from = from; @to = to
  end
  def command; "patch"; end
  def to_s
    long_from = Shell.escape((from[0] == ?/ ? "" : repo1.root + "/") + from)
    long_to = Shell.escape((to[0] == ?/ ? "" : repo2.root + "/") + to)
    puts "# Diffing #{long_from} -> #{long_to}" if $config.verbose
    @contents = File.popen("diff --unified #{long_from} #{long_to}") { |io|
      io.read
    }

    mark = "_SHPATCHMARK_"
    # Make mark unique
    mark += rand(10).to_s while @contents.index(mark)
    "#{command} <<#{mark}\n#{@contents}#{mark}"
  end
end

# A filesystem as backing store
class FileSystem
  SHPATCHSTATE_FILE = ".shpatch.state"
  SHPATCHSTATE_VERSION_STRING = "shpatch.rb state version 20050418-2"

  attr_accessor :root
  attr_accessor :cache_file # String: filename with signatures
  attr_accessor :signature_cache # From Fixnum inode to Array [mtime, sig]
  attr_accessor :signature_cache_changed # Boolean

  # Reads the cache. When not readable in current directory, go
  # up a level ('..')
  def read_signatures
    @signature_cache = {}
    @signature_cache_changed = false
    @cache_file = File.expand_path("#@root/#{SHPATCHSTATE_FILE}")
    cache_file = @cache_file
    loop {
      if FileTest.readable?(cache_file)
	File.open(cache_file, "rb") do |file|
	  version_string = file.readline.chomp
	  if version_string == SHPATCHSTATE_VERSION_STRING
	    begin
	      @signature_cache = Marshal.load(file) 
	      puts "# Read signature cache with #{@signature_cache.size} signatures from #{cache_file.inspect}" if $config.verbose
	      @cache_file = cache_file
	      break
	    rescue ArgumentError, EOFError
	      puts "# (error reading state file: rebuilding file...)" if $config.verbose
	    end
	  end
	end
      end
      parent_cache_file = File.expand_path(
	File.dirname(cache_file) + "/../" + File.basename(cache_file)
      )
      break if parent_cache_file == cache_file
      cache_file = parent_cache_file
    }
  end

  def initialize(root)
    raise "#{root.inspect} does not exist" if not File.exists?(root)
    @root = root
    read_signatures
  end

  def save_signatures
    # Save all unsaved signature cache
    return if !@signature_cache_changed
    puts "# Saving #{@signature_cache.size} signatures..." if $config.verbose
    pf = @cache_file
    File.open("#{pf}.new", "wb+") do |file|
      file.puts SHPATCHSTATE_VERSION_STRING
      Marshal.dump(@signature_cache, file)
      File.rename("#{pf}.new", pf)
    end      
  end

  # Returns array of [mtime, one-line signature-string]
  def signature(stat, filename)
    signature = nil
    key = [stat.dev, stat.ino]
    cache = @signature_cache[key]
    if cache and (cache[0] == stat.mtime)
      signature = cache[1]
    else
      if $config.verbose
	why = (cache ? "#{(stat.mtime - cache[0]).to_i}s out of date" : "not indexed")
	puts "# Creating signature for #{filename.inspect} (#{why})" 
      end
      signature = MD5.new(File.read(filename)).digest
      @signature_cache[key] = [stat.mtime, signature]
      @signature_cache_changed = true
    end
    signature
  end

  def signature_from(prefix, res, from, ignoreRe)
    Dir.new("#{prefix}#{from}").entries.each { |elem|
      next if (elem == ".") or (elem == "..")
      fullname = "#{prefix}#{from}/#{elem}"
      if not fullname =~ ignoreRe
	stat = File.stat(fullname)
	if stat.directory?
	  signature_from(prefix, res, "#{from}/#{elem}", ignoreRe) 
	else
	  rel_filename = "#{from}/#{elem}"[1..-1]
	  res[rel_filename] = signature(stat, fullname)
	end
      end
    }
  end

  # Returns all filenames within this filesystem with all signatures
  def signatures(ignoreRe)
    res = {}
    prefix = File.expand_path(@root)
    signature_from(prefix, res, "", ignoreRe)
    save_signatures
    res
  end

  def mime_type(filename)
    path = @root + "/" + filename
    ($mime_cache ||= {})[path] ||=
      File.popen("file --mime #{Shell.escape(path)}") { |io| io.read }.
      gsub(%r{^.*:}, "").strip
  end

  # Read the contents of a file
  def read(filename); File.read(@root + "/" + filename); end
end

patch = []

dir1, dir2 = $config.paths
repo1 = FileSystem.new(dir1)
repo2 = FileSystem.new(dir2)

def re_from_globs(globs)
  Regexp.new(
    "(\\A|/)(" + globs.collect { |glob| 
       Regexp.escape(glob).gsub("\\*", "[^/]*")
    }.join("|") + ")$"
  )
end

ignore_globs += ["BitKeeper/etc/ignore", ".cvsignore"].collect { |a|
  ["#{dir1}/#{a}", "#{dir2}/#{a}"]
}.flatten.find_all { |f| File.exists?(f) }.collect { |f|
  File.readlines(f).collect { |line| line.chomp }
}.flatten
ignore_globs = ignore_globs.uniq.sort
ignoreRe = re_from_globs(ignore_globs)

puts "# Retrieving signatures of #{dir1.inspect}" if $config.verbose
file2sig1 = repo1.signatures(ignoreRe)
puts "# Retrieving signatures of #{dir2.inspect}" if $config.verbose
file2sig2 = repo2.signatures(ignoreRe)
files1 = file2sig1.keys.sort
files2 = file2sig2.keys.sort
common_files = files1 - (files1 - files2)

# Different hash, same filename: patch
common_files.each { |fname|
  if file2sig1[fname] != file2sig2[fname]
    patch << PatchHunk.new(repo1, fname, repo2, fname)
  end
  file2sig1.delete(fname)
  file2sig2.delete(fname)
}

# Same hash, different filename: rename
sig2file1 = file2sig1.invert
sig2file2 = file2sig2.invert
sigs1 = sig2file1.keys
sigs2 = sig2file2.keys
common_sigs = sigs1 - (sigs1 - sigs2)
common_sigs.each { |sig|
  from = sig2file1[sig]
  to = sig2file2[sig]
  patch << RenameHunk.new(from, to)
  sig2file1.delete(sig)
  sig2file2.delete(sig)
  file2sig1.delete(from)
  file2sig2.delete(to)
}

# statistics of contents of a file. Used for quick-compare
class FileContentStats
  attr_accessor :size		# Size of file in lines
  attr_accessor :lines		# Hash from String to Fixnum

  # Counter number of lines removed and added as a percentage
  # of the total file length. These are a measure for the degree
  # of matching between the files.
  def diff_match(other)
    added = 0
    removed = 0
    @lines.each_pair { |line, count|
      delta = other.lines[line] - count
      if delta > 0
	added += delta
      else
	removed += -delta
      end
    }
    other.lines.each_pair { |line, count|
      added += count if not @lines[line]
    }
    [added * 100 / other.size, removed * 100 / self.size]
  end

  def initialize(repo, path)
    @lines = Hash.new(0)
    size = 0
    repo.read(path).delete("\0").each_line { |line|
      @lines[line.intern] += 1
      size += 1
    }
    @size = size
  end

  def self.cached(repo, path)
    @@cache ||= {}
    @@cache[[repo, path]] ||= self.new(repo, path)
  end
end

# Categorize a file based on filename and/or contents
def pool_type(repo, path)
  res = []
  res << File.basename(path) if $config.same_base
  res << File.extname(path) if $config.same_ext
  res << repo.mime_type(path) if $config.same_mime
  res
end

# Determine how much a filename looks like another filename
# by splitting the filenames into words. Then count the
# words which are the same.
def path_correlation(path1, path2)
  comp1 = path1.split(%r{[-._/]})
  comp2 = path2.split(%r{[-._/]})
  (comp1 - (comp1 - comp2)).size
end

class Array
  # The inverse of an array is an hash from contents to index number.
  def inverse; res = {}; each_with_index { |e, idx| res[e] = idx }; res; end
end

if $config.changed_content
  files1 = file2sig1.keys.sort
  files2 = file2sig2.keys.sort
  all_added_files = files2 - files1
  all_removed_files = files1 - files2

  pools = {}			# Group files into 'pools'
  all_removed_files.each { |removed_file|
    (pools[pool_type(repo1, removed_file)] ||= [[], []])[0] << removed_file
  }
  all_added_files.each { |added_file|
    (pools[pool_type(repo2, added_file)] ||= [[], []])[1] << added_file
  }

  pools.each_pair { |key, pool|
    removed_files, added_files = *pool
    if $config.verbose and not removed_files.empty? and not added_files.empty?
      puts "# Comparing pool type #{key.inspect} with #{pool[0].size}x#{pool[1].size} filepairs" 
    end

    # Determine how 'special' or 'specific' a word is. We start with
    # filenames containing special words.
    words = {}			# Group files by 'words'
    removed_files.each { |removed_file|
      removed_file.split(%r{[-._/]+}).uniq.each { |word|
	words[word] ||= [[], []]
	words[word][0] << removed_file
      }
    }
    added_files.each { |added_file|
      added_file.split(%r{[-._/]+}).uniq.each { |word|
	words[word] ||= [[], []]
	words[word][1] << added_file
      }
    }
    word_importance = words.keys.find_all { |word|
      (words[word][0].size * words[word][1].size) > 0
    }.sort_by { |word|
      words[word][0].size * words[word][1].size
    }.reverse
#    p word_importance
    word_importance = word_importance.inverse
    word_importance.default = 0

    removed_files.sort_by { |removed_file|
      removed_file.split(%r{[-._/]+}).uniq.inject(0) { |s, e|
	[s, word_importance[e]].max
      }
    }.reverse.each { |removed_file|
#      puts removed_file
      removed_file_stats = FileContentStats.new(repo1, removed_file)
      added_files.sort_by { |f| -path_correlation(removed_file, f) }.
        each { |added_file|
	added_file_stats = FileContentStats.cached(repo2, added_file)
	removed_size = removed_file_stats.size
	added_size = added_file_stats.size
	min_added = (added_size - removed_size) * 100 / added_size
	next if min_added > $config.max_added
	min_removed = (removed_size - added_size) * 100 / removed_size
	next if min_removed > $config.max_removed
	
	# Calculate added & removed percentages
	added, removed = removed_file_stats.diff_match(added_file_stats)
	if (added <= $config.max_added) && (removed <= $config.max_removed)
	  # We found a rename-match!
	  puts "+%2i%% -%2i%% #{removed_file} -> #{added_file}" % [added, removed] #if $config.verbose
	  patch << RenameHunk.new(removed_file, added_file)
	  # Don't match again against this added file:
	  added_files -= [added_file]
	  all_added_files -= [added_file]
	  all_removed_files -= [removed_file]
	  patch << PatchHunk.new(repo1, removed_file, repo2, added_file)
	  break
	end
      }
    }
  }
end

all_added_files.each { |added_file|
  patch << PatchHunk.new(repo1, "/dev/null", repo2, added_file)
}
all_removed_files.each { |removed_file|
  patch << PatchHunk.new(repo1, removed_file, repo2, "/dev/null")
}

#patch.each { |hunk| puts hunk.to_s }

--ReaqsoxgOBHFXBhH--
